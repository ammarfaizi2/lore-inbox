Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268038AbTBRVsU>; Tue, 18 Feb 2003 16:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTBRVsU>; Tue, 18 Feb 2003 16:48:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31756 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268038AbTBRVsT>; Tue, 18 Feb 2003 16:48:19 -0500
Date: Tue, 18 Feb 2003 22:58:19 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, davej@suse.de, linux@brodo.de
Subject: Re: Select voltage manually in cpufreq
Message-ID: <20030218215819.GC21974@atrey.karlin.mff.cuni.cz>
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

Well, and does slow-low-power mean 300MHz, 1.4V as bios said, or
300MHz, 1.2V which is probably also safe?

What about
"as-fast-as-possible-but-not-exceed-140MHz-because-batteries-are-
running-low-and-can-not-give-enough-current"? That's different from
"fast-high-power", but it is *also* different from
"slow-low-power". [This actually matters on beasts like zaurus]. What
about
"as-low-power-as-possible-but-make-sure-you-can-keep-display-up"? [On
some machines cpu must be > some HMz for display to still work].

Power managment is complex...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
