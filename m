Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQKAKHQ>; Wed, 1 Nov 2000 05:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129820AbQKAKHG>; Wed, 1 Nov 2000 05:07:06 -0500
Received: from [62.172.234.2] ([62.172.234.2]:13934 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129552AbQKAKGv>;
	Wed, 1 Nov 2000 05:06:51 -0500
Date: Wed, 1 Nov 2000 10:07:49 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: hang ftp connections...
In-Reply-To: <Pine.LNX.4.21.0011011000580.1722-100000@saturn.homenet>
Message-ID: <Pine.LNX.4.21.0011011007200.1722-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Tigran Aivazian wrote:

> Hi guys,
> 
> I noticed this since I installed test10-pre5 (maybe 6) on my
> desktop. FTP connections to Solaris became very strange, i.e. after the
> transfer is finished it would never actually close the control socket and
> hang it there. So, I assumed that most likely Solaris kernel is full of
> bugs (as a commercial OS ought to be) and they don't even implement FTP
                                                                      ~~~

did I say FTP? I meant TCP :) Though it would be nice to see a kernel with
kFTP in it :)

> protocol correctly, so that the exceeding correctness of ours at
> test10-preX shows their bugs. However, now the same thing happened when
> talking to ftp.kernel.org and that surely runs Linux. So there must be a
> bug somewhere. I will now upgrade all my systems to final proper test10
> and see if the problem is still there...
> 
> I only noticed this with ftp; other critical services (irc, telnet etc.)
> work fine.
> 
> Regards,
> Tigran
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
