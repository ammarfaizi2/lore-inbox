Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbTC3Tcj>; Sun, 30 Mar 2003 14:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbTC3Tci>; Sun, 30 Mar 2003 14:32:38 -0500
Received: from [195.39.17.254] ([195.39.17.254]:14596 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261525AbTC3Tbs>;
	Sun, 30 Mar 2003 14:31:48 -0500
Date: Fri, 28 Mar 2003 21:49:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: add eeprom i2c driver
Message-ID: <20030328204913.GF5147@zaurus.ucw.cz>
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com> <3E8175FF.7060705@portrix.net> <20030326212923.GB26886@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326212923.GB26886@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >can see, it takes about 100 lines of code off of this driver, which is
> > >nice.
> > >
> > I thought about doing something like this for adding sysfs support.
> > Should the voltages and other data appear as integer or as floats in 
> > sysfs tree? (ie. 1.20V or 120cV)
> 
> floats are a pain!

Why? Real world measurements *are*
floating point, and we are going to be
limited with centivolts at some point.
Floating point seems right...

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

