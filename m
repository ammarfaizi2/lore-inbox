Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268052AbTBRWGM>; Tue, 18 Feb 2003 17:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268056AbTBRWGM>; Tue, 18 Feb 2003 17:06:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43791 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268052AbTBRWGI>; Tue, 18 Feb 2003 17:06:08 -0500
Date: Tue, 18 Feb 2003 23:16:08 +0100
From: Pavel Machek <pavel@suse.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, davej@suse.de, linux@brodo.de
Subject: Re: Select voltage manually in cpufreq
Message-ID: <20030218221608.GE21974@atrey.karlin.mff.cuni.cz>
References: <20030218214220.GA1058@elf.ucw.cz> <20030218214726.GB15007@f00f.org> <20030218215819.GC21974@atrey.karlin.mff.cuni.cz> <20030218220858.GA15273@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030218220858.GA15273@f00f.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, and does slow-low-power mean 300MHz, 1.4V as bios said, or
> > 300MHz, 1.2V which is probably also safe?
> 
> I have no idea... that's the point... the user almost never knows what
> *exact* magic values are required, they just want fast-on-power or
> slow-on-battery sort of thing.

Well, but system also does not know. And *I* need a way to tell my
system what the right thing is.

> > What about
> > "as-fast-as-possible-but-not-exceed-140MHz-because-batteries-are-
> > running-low-and-can-not-give-enough-current"? That's different from
> > "fast-high-power", but it is *also* different from
> > "slow-low-power". [This actually matters on beasts like
> > zaurus]. What about
> > "as-low-power-as-possible-but-make-sure-you-can-keep-display-up"?
> > [On some machines cpu must be > some HMz for display to still work].
> 
> this just shows how silly these complex schemes are
> 
> you pick two options, a slow and fast option; both should work

Well, but this simple user interface means pretty complicated
insides. 
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
