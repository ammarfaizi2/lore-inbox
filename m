Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSK0RmN>; Wed, 27 Nov 2002 12:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSK0RmN>; Wed, 27 Nov 2002 12:42:13 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:33542 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264649AbSK0RmM>; Wed, 27 Nov 2002 12:42:12 -0500
Date: Wed, 27 Nov 2002 17:49:28 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: Fbdev 2.5.49 BK fixes.
In-Reply-To: <3DE4A6CF.F62CFF41@aitel.hist.no>
Message-ID: <Pine.LNX.4.44.0211271747510.30951-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I tried this patch, but it crashed during boot.

Any oops info? 

> I have a 
> 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
> 1X/2X (rev 5c)
> 
> and use this in lilo.conf:
> image=/boot/2.5.49fb
>         label=2.5.49fb
>         append="video=atyfb:1280x1024-16@85"

Hm. Are you using a PPC or ix86 box? I will test this tonight.
 
> This got me a 160x64 framebuffer with yellow text on
> blue background.  Nice, but only got about 10 lines before
> the kernel hung. The disk light got stuck on and there were
> no response to things like sysrq.  
> The few lines displayed was about the fb, drm, and finally
> the 3com network adapter.  Then nothing more.

Sounds like panning flipped put.
 
> 2.5.49 without this patch works.  I use devfs & preempt,
> the machine is UP and I use gcc-2.95.4 for compiling.

