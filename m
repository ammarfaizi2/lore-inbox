Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVGWRUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVGWRUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVGWRUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 13:20:54 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:64700 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262370AbVGWRUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 13:20:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] Re: [RFT] solve "swsusp plays yoyo" with disks
Date: Sat, 23 Jul 2005 19:20:28 +0200
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@ucw.cz>, Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       B.Zolnierkiewicz@elka.pw.edu.pl,
       kernel list <linux-kernel@vger.kernel.org>
References: <20050705172953.GA18748@elf.ucw.cz> <42DFBFA8.5060800@stud.feec.vutbr.cz> <20050721192015.GA6367@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050721192015.GA6367@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507231920.29336.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 21 of July 2005 21:20, Pavel Machek wrote:
> hi!
> 
> > >>I'd like to get this tested under as many configurations as
> > >>possible. With this, your hdd should no longer do "yoyo" (spindown,
> > >>spinup, spindown) during suspend...
> > >
> > >
> > >It looks like the patch is now in -mm (I use 2.6.13-rc3-mm1).
> > >But my disks still yoyo during suspend. What more is needed? Some patch 
> > >to ide-disk.c ?
> > 
> > I think I've found the problem.
> > The attached patch stops the disks from spinning down and up on suspend.
> > The patch applies to 2.6.13-rc3-mm1.
> > 
> > Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
> 
> Thanks, applied, I'll eventually propagate it.

FYI, tested and works (on 2.6.13-rc3). :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
