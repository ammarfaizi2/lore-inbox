Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTIPRPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTIPROV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:14:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40677 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262003AbTIPROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:14:17 -0400
Date: Sun, 14 Sep 2003 11:32:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Pat LaVarre <p.lavarre@ieee.org>, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: console lost to Ctrl+Alt+F_n in 2.6.0-test5
Message-ID: <20030914093205.GA7357@openzaurus.ucw.cz>
References: <1063378664.5059.19.camel@patehci2> <1063460312.2905.13.camel@patehci2> <200309132249.40283.mhf@linuxmail.org> <200309132347.37831.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309132347.37831.mhf@linuxmail.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Don't think this is a keyboard problem and have seen
> > this several times related to video drivers in particular
> > when switching back to X.
> 
> Used script with 2.6.0-test5 + pm2 patch
> 
> Kernel: VGA16FB 
> 
> X4.3:	Driver      "vesa"
> 	VendorName  "Silicon Integrated Systems [SiS]"
> 	BoardName   "VESA driver (generic)"
> 
> 200 cycles wo problems.

VESA is special: its kernel who drives the hw => X can't crash it
so easily.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

