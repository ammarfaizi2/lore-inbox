Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSK0SAu>; Wed, 27 Nov 2002 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSK0SAt>; Wed, 27 Nov 2002 13:00:49 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62470 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261900AbSK0SAs>; Wed, 27 Nov 2002 13:00:48 -0500
Message-ID: <3DE50A1D.856A8706@aitel.hist.no>
Date: Wed, 27 Nov 2002 19:08:29 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.49 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Fbdev 2.5.49 BK fixes.
References: <Pine.LNX.4.44.0211271747510.30951-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > I tried this patch, but it crashed during boot.
> 
> Any oops info?
No.  The machine froze solid. No oops, no sysrq.
The reset button worked.
> 
> > I have a
> > 01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
> > 1X/2X (rev 5c)
> >
> > and use this in lilo.conf:
> > image=/boot/2.5.49fb
> >         label=2.5.49fb
> >         append="video=atyfb:1280x1024-16@85"
> 
> Hm. Are you using a PPC or ix86 box? I will test this tonight.
i386.  Specifically, a pentium II, compiled for pentium II.

> > This got me a 160x64 framebuffer with yellow text on
> > blue background.  Nice, but only got about 10 lines before
> > the kernel hung. The disk light got stuck on and there were
> > no response to things like sysrq.
> > The few lines displayed was about the fb, drm, and finally
> > the 3com network adapter.  Then nothing more.
> 
> Sounds like panning flipped put.
> 
Perhaps. It didn't look like it ended at the bottom of the
screen, but then it might have been panning at the wrong moment.

> > 2.5.49 without this patch works.  I use devfs & preempt,
> > the machine is UP and I use gcc-2.95.4 for compiling.

Helge Hafting
