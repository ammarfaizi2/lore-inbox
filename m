Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbUBGCfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 21:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbUBGCfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 21:35:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:26576 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265975AbUBGCfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 21:35:12 -0500
Date: Sat, 7 Feb 2004 02:35:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Murilo Pontes <murilo_pontes@yahoo.com.br>, linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040207023510.GI12503@mail.shareable.org>
References: <200402041820.39742.wnelsonjr@comcast.net> <200402051517.37466.murilo_pontes@yahoo.com.br> <20040205203840.GA13114@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205203840.GA13114@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Feb 05, 2004 at 05:24:27PM +0000, Murilo Pontes wrote:
> > I try kernel with/without  preempty/acpi/apic make all possibilities, 
> > then may be error is not in kernel, but in XFree86-4.3.0 which not support big changes in input system
> > of 2.6.x, I tried compile XFree86 with linux-2.6.{0,1,2} kernel headers was 100% fail, sounds binary 
> > and source incompatibilites,  
> 
> Hey, guys, could you possibly try to figure out what your machines have
> in common? I've switched all my computers to PS/2 mice so that I have a
> bigger chance to reproduce the problem, but it is not happening on any
> of them.

Heh.  I have a USB mouse and I see similar problems:

Red Hat 9 (more or less), XFree86-4.3.0-2, kernel 2.6.0-test10, dual
athlon, USB Logitech optical mouse, configured to read from
/dev/input/mice (only!).

Every few hours the mouse suddenly jumps to a corner of the screen and
seems broken for a second or so.  After that I can move it back to
where it is useful.

I never noticed such behaviour when running 2.4 on this box, nor when
running earlier 2.6 kernels.

There is nothing about "atkbd" or "mouse" or "lost synchronisation" in
the kernel log.

-- Jamie
