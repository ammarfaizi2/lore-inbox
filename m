Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbTC3Td0>; Sun, 30 Mar 2003 14:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbTC3Tcm>; Sun, 30 Mar 2003 14:32:42 -0500
Received: from [195.39.17.254] ([195.39.17.254]:13828 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261526AbTC3Tbv>;
	Sun, 30 Mar 2003 14:31:51 -0500
Date: Fri, 28 Mar 2003 19:34:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Mark Studebaker <mds@paradyne.com>, Jan Dittmer <j.dittmer@portrix.net>,
       azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030328183410.GD5147@zaurus.ucw.cz>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326225234.GA27436@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> temp_min[1-3]	Temperature min or hysteresis value.
> 		Fixed point value in form XXXXX and should be divided by
> 		100 to get degrees Celsius.  This is preferably a

I believe floating point is nicer... It is
improbable to have miliKelvins around,
still I don'n see why fixedpoint...
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

