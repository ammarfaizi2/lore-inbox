Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTEMWOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263674AbTEMWOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:14:01 -0400
Received: from waste.org ([209.173.204.2]:56554 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263660AbTEMWMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:12:14 -0400
Date: Tue, 13 May 2003 17:24:54 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4
Message-ID: <20030513222454.GF4108@waste.org>
References: <20030512225504.4baca409.akpm@digeo.com> <87vfwf8h2n.fsf@lapper.ihatent.com> <20030513001135.2395860a.akpm@digeo.com> <87n0hr8edh.fsf@lapper.ihatent.com> <20030513011232.67c300d0.akpm@digeo.com> <87addq7fr8.fsf@lapper.ihatent.com> <20030513145335.2337e0f7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513145335.2337e0f7.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:53:35PM -0700, Andrew Morton wrote:
> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > * Synaptics touchpad driver as of 2.5.69 does not recognise the "tap
> >   to click" functionality, and doesn't seem parse it's boot param to
> >   enable it, I get it to work by hardcoding the PARM-line in
> >   driver/input/mouse/psmouse.c to a "1". This might very well boil
> >   down to user error (PEBKAC) on the boot time parm, but the auto
> >   detection that worked up to .69 is b0rken.
> 
> There's some synaptics patch in -mm which looks like it needs
> 
> 	modprobe psmouse synaptics_tap=1
> 
> I'm not sure what the story is on getting all that finished off.

While we're on the subject I'll mention that the 2.5 input layer sees
only the touchpad on my T30, and not the trackpoint. The psaux driver
in 2.4 works fine.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
