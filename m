Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVJJOHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVJJOHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVJJOHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:07:14 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:49421 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750803AbVJJOHN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:07:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lPCJvRZ84Qyeaw+Xqi7nGWH0/89FXT7RAS6amFA4Jj6jgjdYt+7Y7SjNZWxTS/Ba2l/9Cj1SdiY7U0SyMmS0nxNoqYpr1vvafu4LJ9oS9nxYJA73I11tUW9xbiwgjL9qZdak0AL1PckgqwbyXwfYjeVge5XJMF6IkcCNeoF21Gs=
Message-ID: <9e0cf0bf0510100707x5022737ahabc9ae439190719a@mail.gmail.com>
Date: Mon, 10 Oct 2005 16:07:11 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
Reply-To: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
In-Reply-To: <434A7363.40002@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4315B668.6030603@gmail.com> <431628D5.1040709@zytor.com>
	 <431DF9E9.5050102@gmail.com> <431DFEC3.1070309@zytor.com>
	 <431E00C8.3060606@gmail.com> <4345A9F4.7040000@uni-bremen.de>
	 <434A6220.3000608@gmx.de>
	 <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com>
	 <9e0cf0bf0510100632i79b4b4cdk24935724d6ab1ed7@mail.gmail.com>
	 <434A7363.40002@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Georg Lippold <georg.lippold@gmx.de> wrote:
> Hi,
>
> > 1. Why don't you put this variable at config, and allow the user to
> > specify the length during configuration? I have a patch that does just
> > that.
> If you'd post it, it would probably get more attention :)

I got enough attention... I just wait for documentation update... This
is the important mile-stone for this change...

> > 2. THE MOST IMPORTANT task is to update the documentation at
> > Without this fix the bootloaders (Lilo, Grub) will not fix their
> > code... So that users will still will not be able to use > 256 command
> > line.
>
> syslinux >=3.09 supports 512 chars.

Unless the documentation will be updated and it will be clear that the
boot protocol allows long command-line strings that are truncated by
the kernel at max, this task is not finished... the fact that there is
one bootloader that does that is not enough... Regardless... 512 bytes
is too small...

Best Regards,
Alon Bar-Lev.
