Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbUBPV61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUBPV61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:58:27 -0500
Received: from poup.poupinou.org ([195.101.94.96]:2615 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S265918AbUBPV6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:58:02 -0500
Date: Mon, 16 Feb 2004 22:57:56 +0100
To: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: 2.6.2: P4 ClockMod speed
Message-ID: <20040216215756.GU13262@poupinou.org>
References: <20040216213435.GA9680@dominikbrodowski.de> <40313AA9.1060906@arenanetwork.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40313AA9.1060906@arenanetwork.com.br>
User-Agent: Mutt/1.5.4i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 09:48:25PM +0000, dual_bereta_r0x wrote:
> Dominik Brodowski wrote:
> >Hi,
> >
> >
> >>I have a P4 2.4 running @ 3.12GHz.
> >
> >
> >So you overclock your CPU but then throttle it down... strange, but well...
> 
> Actually it isn't throttled down, only sysfs is showing it with low 
> speed. It *is* running @ 3.12 (or /proc/cpuinfo and boot messages are 
> lying to me) when in full power.

/proc/cpuinfo is lying.

Use something like bogomips, and look if that's actually make a difference.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
