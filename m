Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262995AbTC0PBc>; Thu, 27 Mar 2003 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbTC0PBc>; Thu, 27 Mar 2003 10:01:32 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:13792 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S262995AbTC0PBb>;
	Thu, 27 Mar 2003 10:01:31 -0500
Subject: Re: Linux 2.4.21-pre6 (about PPC32)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303271555.55944.gallir@uib.es>
References: <200303271555.55944.gallir@uib.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048777963.1209.1.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Mar 2003 16:12:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 15:55, Ricardo Galli wrote:
> > Support Radeon 9K variants in radeonfb.
> > 
> > Well...
> >  
> > I have a bunch of quite important radeonfb updates (including all
> > these new chipset support stuffs) that are waiting for Ani (the
> > maintainer) to send them to Marcelo.
> 
> I don't know how they are related to you benX version available via rsync, 
> but in ben9 the X server goes to a loop right after resuming on a iBook 
> G3-500 with 7500-M. I was reported it happens also on G3-800 with radeon.

Make sure you have APM emulation enabled in the kernel /dev/apm_bios
exist. If you are using DRI, also make sure to have AGPMode "4".

> Also, dmasound stopped working in the G3-500, it gives a "No space left in 
> device" error while trying to write to /dev/dsp. My last working version 
> is 2.4.20-rc1-ben0. I think I already reported to you, but just in case.

That's not a known problem... and I can't reproduce it on my tipb which
supposedly uses the same HW...

Ben

