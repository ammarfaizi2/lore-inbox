Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVISCNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVISCNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 22:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVISCNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 22:13:10 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:18653 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932292AbVISCNJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 22:13:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XIXveo1P3vAFyLwepxR0Km1keM2h6LWm0eOdTxTH7B+5Ha+EqmPTck1bwArL4D4NGY6WSj6o/vA+mR2rQeLssKTJwoiS+HzL2K5IErXU58Xt8LrgE+H/5b8KZZNVvKI0gaXOXZMB1PfvEpUk6HzreNRdCH+sbdJ93iTSVZa87UA=
Message-ID: <2cd57c90050918191328ce3888@mail.gmail.com>
Date: Mon, 19 Sep 2005 10:13:05 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [i386 BOOT CODE] kernel bootable again
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <hhumctao447z.1cmhqs2q8ab2s.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192>
	 <432722A1.8030302@tuxrocks.com> <43272B9D.1030301@zytor.com>
	 <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
	 <1rhnij9opqgby$.4jlz2jfqsmkc$.dlg@40tude.net>
	 <9a8748490509170856a1b9428@mail.gmail.com>
	 <hhumctao447z.1cmhqs2q8ab2s.dlg@40tude.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/05, Giuseppe Bilotta <bilotta78@hotpop.com> wrote:
> On Sat, 17 Sep 2005 17:56:08 +0200, Jesper Juhl wrote:
> 
> >> This is probably a stupid suggestion, but here it goes anyway: the
> >> kernel has to be written on disk by something, right?
> >>
> >> So if the "something" knows (or can get to know) the sector/tracks
> >> layout of the disk it's writing the kernel onto, it could store this
> >> information in the bootblock (is there space for that?). The bootblock
> >> code would then just read this info and use it.
> >>
> >> Of course, this would mean that making a kernel-bootable floppy
> >> wouldn't be as simple as cp'ing the kernel image to /dev/fdwhatever,
> >> but if a script/program designed to do this was included with the
> >> kernel source (it wouldn't be too big ...) ...
> >>
> > I may be missing something here, but if you are going to do something
> > like that, then why not just use a real bootloader instead?
> 
> I'm not too much into this stuff, I don't even know the technical
> differences betwen booting from kernel-on-floppy or from a bootloader.
> My proposal was just to work around the "what's the track layout"
> issue in the kernel-on-floppy direct boot. Maybe you could see it like

Actually, DOS/Windows works that way. FAT filesystem stores the number
of sectors per track in its boot sector.

> a delayed bootloader process ... don't know.
> 
> But as I mentioned, it was probably just a stupid suggestion :)

You are too humble. It's not you, but linux bootsect.S stupid IMHO. ;)
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
