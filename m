Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTIHPdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTIHPcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:32:16 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:43221 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262423AbTIHPb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:31:59 -0400
Date: Mon, 8 Sep 2003 08:26:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert Schwebel <robert@schwebel.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030908152622.GB836@ip68-0-152-218.tc.ph.cox.net>
References: <20030907112813.GQ14436@fs.tum.de> <20030907124251.GC5460@pengutronix.de> <20030907130034.GT14436@fs.tum.de> <20030907131443.GD5460@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907131443.GD5460@pengutronix.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 03:14:43PM +0200, Robert Schwebel wrote:

> On Sun, Sep 07, 2003 at 03:00:34PM +0200, Adrian Bunk wrote:
> > I didn't look at the ARM Makefile. Thanks for the note, I'll have a
> > look at it before I'll do the revision of this patch.
> 
> You should definitely discuss this with rmk. How do the PPC folks handle
> CPU selection? 

We don't allow for one kernel to work on something outside of a
'family', nor do we (aside from MULTIPLATFORM) allow a kernel to work on
> 1 board type (maybe we'll fix that in 2.7).  You can pick 8xx
(MPC8xx line), 8260 (MPC826x/MPC827x, and should be fixed up to into
classic), 6xx/7xx/74xx (aka 'classic' PPC, 40x and 44x.

-- 
Tom Rini
http://gate.crashing.org/~trini/
