Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270758AbRHWXlM>; Thu, 23 Aug 2001 19:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270746AbRHWXlA>; Thu, 23 Aug 2001 19:41:00 -0400
Received: from [209.38.98.99] ([209.38.98.99]:36481 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S270772AbRHWXkt>;
	Thu, 23 Aug 2001 19:40:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fred <fred@arkansaswebs.com>
To: Tony Hoyle <tmh@nothing-on.tv>
Subject: Re: File System Limitations
Date: Thu, 23 Aug 2001 18:40:59 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01082316383301.12104@bits.linuxball> <01082318132000.12319@bits.linuxball> <3B858F58.1000606@nothing-on.tv>
In-Reply-To: <3B858F58.1000606@nothing-on.tv>
MIME-Version: 1.0
Message-Id: <01082318405901.12319@bits.linuxball>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

glibc-2.2.2-10

dd if=/dev/zero of=./tgb count=4000 bs=1M

created file of 2147483647 bytes

[root@bits /a5]# dd if=/dev/zero of=./tgb count=4000 bs=1M
File size limit exceeded (core dumped)
[root@bits /a5]#

is glibc part of gcc? where do i find glibc?
(I've recently compiled gcc-3.00, but won't install cause it breaks kernel 
compilations).



TIA

Fred

 _________________________________________________ 
On Thursday 23 August 2001 06:18 pm, Tony Hoyle wrote:
> Fred wrote:
> > so why dos my filesystem have a 2 GB limit?
> > Must I specify a large block size or some such when i format?
> >
> > i run 2.4.9 on redhat7.1 out of the box
>
> Does it?  Unless RH are using a seriously old glibc (which I doubt)
> there's no 2GB limit any more.
>
> Some older applications don't work with it AFAIK... anything bundled
> with a modern distro shouldn't have any problems.
>
> Tony
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
