Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131716AbQKSH2W>; Sun, 19 Nov 2000 02:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131912AbQKSH2M>; Sun, 19 Nov 2000 02:28:12 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:22311 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131716AbQKSH2G>; Sun, 19 Nov 2000 02:28:06 -0500
Message-ID: <3A1779D9.409FB87B@linux.com>
Date: Sat, 18 Nov 2000 22:57:29 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Park <apark@cdf.toronto.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: neighbour table?
In-Reply-To: <Pine.LNX.4.21.0011190158480.3036-100000@blue.cdf.utoronto.ca>
Content-Type: multipart/mixed;
 boundary="------------09D0636F29856D42487CB66B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------09D0636F29856D42487CB66B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew Park wrote:

> I get a message
>
>         neighbour table overflow
>
> What does that mean?  It seems that
>
>         net/ipv4/route.c
>
> is the place where it prints this.  But under what circumstances
> does this happen?
> Thanks

It means you set the link state of eth0 up before lo.

Be sure lo is established before eth0 and you won't see this message.

-d


--------------09D0636F29856D42487CB66B
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------09D0636F29856D42487CB66B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
