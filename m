Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbTC3TdZ>; Sun, 30 Mar 2003 14:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTC3Tcy>; Sun, 30 Mar 2003 14:32:54 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18180 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261529AbTC3Tb5>;
	Sun, 30 Mar 2003 14:31:57 -0500
Date: Sun, 30 Mar 2003 21:23:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>,
       azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030330192312.GB6666@zaurus.ucw.cz>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327172516.GA32667@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >	       	Floating point values XXX.X or XXX.XX in degrees Celcius.
> > 
> > If we're restructuring it, I think we should also agree on _one_ common 
> > denominator for all values ie. mVolt and milli-Degree Celsius, so that 
> > no userspace program ever again has know how to convert them to 
> > user-readable values and every user can just cat the values and doesn't 
> > have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
> > or whatever.
> 
> Um, that's what my proposal stated.  Do you not agree with it?  (You're
> quoting the existing document above, not my proposed changes.)

Well, you had cV for PSU voltages and
mV for cpu core voltage. I guess mV
and mili-deg-C everywhere would be
nicer. 

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

