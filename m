Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268931AbTBSPVc>; Wed, 19 Feb 2003 10:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbTBSPVc>; Wed, 19 Feb 2003 10:21:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64783 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268931AbTBSPVa>; Wed, 19 Feb 2003 10:21:30 -0500
Date: Wed, 19 Feb 2003 16:31:26 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, davej@suse.de, linux@brodo.de
Subject: Re: Select voltage manually in cpufreq
Message-ID: <20030219153124.GB14549@atrey.karlin.mff.cuni.cz>
References: <20030218214220.GA1058@elf.ucw.cz> <20030218214726.GB15007@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218214726.GB15007@f00f.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I've added possibility to manualy force specified frequency and
> > voltage... That's fairly usefull for testing, and I believe this (or
> > something equivalent) is needed because every 2nd bios seems to be
> > b0rken.
> 
> Why are all the power/cpu patches so complex?  Can't we have a
> two-mode style operation, "slow-low-power" and "fast-high-power" or
> something?  Would that not work with 99% or what people need and also
> be somewhat more uniform across platforms, CPUs, etc?

Another point here: This laptop machine allows scalling from 900MHz
back down to ~45MHz (actually 300MHz+throttling). If user said
"slow-low-power" he probably did not mean 45MHz, still it would be
nice to expose full range to the user.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
