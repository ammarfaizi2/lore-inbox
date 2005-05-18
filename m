Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVERUme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVERUme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVERUme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:42:34 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:17282 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262357AbVERUmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:42:32 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 18 May 2005 13:41:47 -0700
From: Tony Lindgren <tony@atomide.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <20050518204147.GM27330@atomide.com>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org> <20050518185016.GD1952@elf.ucw.cz> <1116443033.5419.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116443033.5419.3.camel@mindpipe>
User-Agent: mutt-ng 1.5.9i (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com> [050518 12:06]:
> On Wed, 2005-05-18 at 20:50 +0200, Pavel Machek wrote:
> > Please don't do this, CONFIG_NO_IDLE_HZ patches are better solution,
> > and they worked okay last time I tried them.
> 
> Last time the dynamic tick patches were posted, you reported they worked
> fine.  The next question is, when do they get merged?

Uh, I've been meaning to do some clean-up on the x86 patch, but been
distracted every time I've tried... I'll try to do an updated patch
soon... But meanwhile, I believe the dyn-tick patch works reliably
on all machines if DYN_TICK_USE_APIC is not set in Kconfig.

Tony
