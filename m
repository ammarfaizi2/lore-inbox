Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263341AbTDCKio>; Thu, 3 Apr 2003 05:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263347AbTDCKio>; Thu, 3 Apr 2003 05:38:44 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:28037 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263341AbTDCKin>; Thu, 3 Apr 2003 05:38:43 -0500
Date: Thu, 3 Apr 2003 11:49:44 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jan Dittmer <j.dittmer@portrix.net>,
       Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030403104944.GB15633@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
	Jan Dittmer <j.dittmer@portrix.net>,
	Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org,
	KML <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com
References: <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com> <20030330192312.GB6666@zaurus.ucw.cz> <20030331224439.A7000@kroah.com> <20030401190240.GA6456@suse.de> <20030403002822.GB5130@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403002822.GB5130@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 04:28:22PM -0800, Greg KH wrote:

 > > FWIW, I'm taking the same fixed-point millivolt approach with the
 > > sysfs overrides for cpufreq.  Having similar things in sysfs
 > > exporting the same units seems to be a good idea.
 > 
 > Hm, in looking around the kernel some more, it seems that there are a
 > number of other places that export voltage and temperature values (ACPI
 > being one of the most obvious.)  It might be time to start thinking of a
 > single userspace library to access all of these kinds of values in a
 > system, instead of having to probe around different parts of the sysfs
 > tree by hand...

Had occured to me too. There was talk of a libpower or the likes
mentioned on acpi-devel a year or so back, but afaik nothing really
came of it.

		Dave

