Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUCZVCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUCZVCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:02:20 -0500
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:17845 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261248AbUCZVCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:02:18 -0500
Date: Fri, 26 Mar 2004 19:30:20 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [.config] CONFIG_THERM_WINDTUNNEL
Message-ID: <20040326183020.GA19610@ibrium.se>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org
References: <200403180821.44199.michal@roszka.pl> <Pine.LNX.4.58.0403181012300.29633@denise.shiny.it> <20040318112057.GC3686@ibrium.se> <Pine.LNX.4.58.0403181221580.1392@denise.shiny.it> <20040318120311.GD3686@ibrium.se> <20040324001828.GB238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324001828.GB238@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 01:18:28AM +0100, Pavel Machek wrote:
> Is it actually possible to set that hardware to self-destruct?
> 
> [ACPI notebooks have very simple hardware failsafe: if temperature
> exceeds some hard limit, power is simply cut.]

Well, I'm not sure.

I know that the hardware which controls the fan (a separate temperature
sensor and a combined sensor/controller) is not connected to any death
switch; the available overheat pin serves as a 100% fan override. There
might very well be a safety mechanism in the UniNorth bridge though.
Something like a forced power off if interrupts are not handled in
a timely manner. I'm pretty sure I have seen references to this behavior
in conjunction with the PowerBook G4. The dual G4 architecture is not all
that different...

It would be interesting to see what happens if one disables the overheat
protection and stops the fan. Anybody volunteering? At least one
has an excellent reason why one need one of those new G5 machines
if things start to smoke :-).

/Samuel
