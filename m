Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTAHL6Z>; Wed, 8 Jan 2003 06:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTAHL6Z>; Wed, 8 Jan 2003 06:58:25 -0500
Received: from [81.2.122.30] ([81.2.122.30]:33028 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267236AbTAHL6W>;
	Wed, 8 Jan 2003 06:58:22 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301081205.h08C5mPv000776@darkstar.example.net>
Subject: Re: [Linux-fbdev-devel] Re: rotation.
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 8 Jan 2003 12:05:48 +0000 (GMT)
Cc: luther@dpt-info.u-strasbg.fr, geert@linux-m68k.org, jsimmons@infradead.org,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <yw1xu1gj51ep.fsf@tiptop.e.kth.se> from "=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=" at Jan 08, 2003 12:25:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I'm about to implement rotation which is needed for devices
> > > > like the ipaq.
> > > > The question is do we flip the xres and yres values depending
> > > > on the rotation or do we just alter the data that will be
> > > > drawn to make the screen appear to rotate. How does hardware
> > > > rotate view the x and y axis?  Are they rotated or does just
> > > > the data get rotated?
> > > 
> > > Where are you going to implement the rotation? At the fbcon or
> > > fbdev level? 
> > > 
> > > Fbcon has the advantage that it'll work for all frame buffer
> > > devices.
> > 
> > But you could also provide driver hooks for the chips which have
> > such a rotation feature included (don't know if such exist, but i
> > suppose they do, or may in the future).

It would be nice to have an option to be able to do the rotation
entirely in software - some desktop users might prefer to have a
portait-orientated display, when their graphics card doesn't have any
hardware rotation facilities at all.

John.
