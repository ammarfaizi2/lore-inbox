Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266916AbUHRPa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266916AbUHRPa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 11:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUHRPa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 11:30:29 -0400
Received: from mail-gw4.njit.edu ([128.235.251.32]:23962 "EHLO
	mail-gw4.njit.edu") by vger.kernel.org with ESMTP id S266916AbUHRPaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:30:14 -0400
Date: Wed, 18 Aug 2004 11:27:56 -0400 (EDT)
From: Rahul Jain <rbj2@oak.njit.edu>
To: "L. A. Walsh" <law@tlinx.org>
cc: Darren Williams <dsw@gelato.unsw.edu.au>, Rahul Jain <rbj2@oak.njit.edu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel recompilation error
In-Reply-To: <41226871.5080900@tlinx.org>
Message-ID: <Pine.GSO.4.58.0408181123030.6808@chrome.njit.edu>
References: <Pine.GSO.4.58.0408162058310.17241@chrome.njit.edu>
 <20040817044343.GA17796@cse.unsw.EDU.AU> <41226871.5080900@tlinx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your response.

I tried compiling a new kernel with the "Loopback Device Support" option
in 'menuconfig' set as a module. However I am still getting the same error.
Is there something more that I am missing ?? I am using RH9

Thanks,
Rahul.

On Tue, 17 Aug 2004, L. A. Walsh wrote:

>
> Yep...if ya ever find yourself running on a no-loop back kernel -- first
> thing to do is compile-up a new one with it enabled so you can make
> new kernels! :-)
>
> -l
>
> Darren Williams wrote:
>
> >Hi Rahul
> >As a guess the kernel you are compiling on
> >does not have loopback enabled and therefore
> >you are seeing this message.
> >
> >I use to see this message on RH7 and 8 if
> >I had no loopback device.
> >
> >Darren
> >
> >On Mon, 16 Aug 2004, Rahul Jain wrote:
> >
> >
> >
> >>Hi,
> >>
> >>This is the first time I am seeing this error while recompiling the
> >>kernel. Could someone plz explain what it means and how to fix it.
> >>
> >>I get this error message when I run the command 'make install'. Till this
> >>point everything else works out properly.
> >>
> >>Error Message
> >>-------------
> >>All of your loopback devices are in use.
> >>mkinitrd failed
> >>
> >>The commands run before this were
> >>make mrproper
> >>make menuconfig
> >>make dep
> >>make bzImage
> >>make modules and
> >>make modules_install
> >>
> >>Thanks,
> >>Rahul.
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>
> >--------------------------------------------------
> >Darren Williams <dsw AT gelato.unsw.edu.au>
> >Gelato@UNSW <www.gelato.unsw.edu.au>
> >--------------------------------------------------
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
> --
>     In the marketplace of "Real goods", capitalism is limited by safety
>     regulations, consumer protection laws, and product liability.  In
>     the computer industry, what protects consumers (other than vendor
>     good will that seems to diminish inversely to their size)?
>
>
>
