Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVBJQQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVBJQQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 11:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVBJQQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 11:16:14 -0500
Received: from styx.suse.cz ([82.119.242.94]:18874 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262105AbVBJQQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 11:16:10 -0500
Date: Thu, 10 Feb 2005 17:16:09 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050210161609.GC19749@ucw.cz>
References: <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209195854.GJ10594@lug-owl.de> <420A77DF.6040108@grupopie.com> <20050209213930.GM10594@lug-owl.de> <20050209215335.GA2634@ucw.cz> <20050210104655.GO10594@lug-owl.de> <420B5C66.8040408@grupopie.com> <20050210134311.GP10594@lug-owl.de> <420B7F40.9080308@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420B7F40.9080308@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 03:35:28PM +0000, Paulo Marques wrote:

> By the way, this has nothing to do with the kernel. The input API can 
> deliver at least 16 bit resolution to user space, so there is no 
> limitation on the software side. It is the A/D resolution that matters.

Make that 32-bit.

> >>Actually a calibration that can do scaling and rotation, can 
> >>automatically compensate for mirroring and/or switched X/Y axes. We 
> >>probably need the user to press 4 points for that, though (3 points are 
> >>enough, but just barely enough).
> >
> >ACK. We'd do a lib for that and have a X11 driver to make use of it.

Remember that the X driver will have to either link statically or the
lib will have to be an X module. X drivers are not allowed to use OS
libs.

> Ok, lets start working on it then :)

Keep that enthusiasm! ;)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
