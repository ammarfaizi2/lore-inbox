Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSHaGCj>; Sat, 31 Aug 2002 02:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSHaGCj>; Sat, 31 Aug 2002 02:02:39 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:42256 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S316235AbSHaGCi>; Sat, 31 Aug 2002 02:02:38 -0400
Date: Sat, 31 Aug 2002 01:07:05 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.10.10208302236560.1033-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0208310100190.23964-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2002, Andre Hedrick wrote:

> 
> Your data is not trashed.

Well actually it was.  After the driver read bad data from the disk 
(presumably mis-addressed) my knee-jerk reaction was to run e2fsk -y to 
"fix" it.  And _that_ trashed the data.


> Linux failed to understand cut off partitions.

???


> When you said you put it on primary channel, I realized that you have a
> system that breaks the rules of Promise and I am not sure.

What are the "rules of Promise" or where may I find such information?


> This will make it more painful to parse systems which can 48-bit and those
> which can not.
> 
> This is not going to be fun.

But this wasn't a problem in 2.4.19-ac4; what confounding factor now is 
making it difficult?


> 
> grep "hwif->addressing" pdc202xx.c
> 
> Stub out the three lines.
> 
> Recompile and reboot, it will be fixed

Will do.  Thanks.  If you have a more permanent fix you'd like me to 
test, let me know.

  -Mike

                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

