Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277743AbRJIPxu>; Tue, 9 Oct 2001 11:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277788AbRJIPxo>; Tue, 9 Oct 2001 11:53:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277743AbRJIPxe>; Tue, 9 Oct 2001 11:53:34 -0400
Date: Tue, 9 Oct 2001 11:53:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel size 
In-Reply-To: <200110091543.f99FhFVJ009433@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.3.95.1011009114946.4152A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Horst von Brand wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> said:
> > On Tue, 9 Oct 2001, Ingo Oeser wrote:
> 
> [...]
> 
> > > strip -R .ident -R .comment -R .note
> > > 
> > > is your friend. 
> 
> [...]
> 
> > Yes! Wonderful...
> > -rwxr-xr-x   1 root     root      1571516 Oct  9 10:50 vmlinux
> > -rwxr-xr-x   1 root     root      1590692 Oct  1 13:26 vmlinux.OLD
> > 
> > That got rid of some cruft.
> 
> Yep. A WHOOPing 1.2% of the total. BTW, is this stuff ever being loaded
> into RAM with the executable kernel, discarded on boot, or what?
> 

Yes. It shows in /proc/kcore. Just wasted. It does mean something
on an embedded system.

It just __might__ mean that I can use a later kernel than 2.4.1
(they grow, you know). I'm mucking with things now.

> IMHO, it would be more productive to go after savings via .init*, and
> perhaps bug the GCC/binutils people to merge strings...
> -- 

It would be nice. I don't mind one advertisement in the kernel, but
presently there is one for every file that was linked.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


