Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbTDCS3Z 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261515AbTDCS3Y 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:29:24 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:26301 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id S261513AbTDCS3U 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:29:20 -0500
Date: Thu, 3 Apr 2003 20:43:42 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Dave Jones <davej@codemonkey.org.uk>, Greg KH <greg@kroah.com>,
       Pavel Machek <pavel@ucw.cz>, Jan Dittmer <j.dittmer@portrix.net>,
       Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org,
       KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com,
       andrew.grover@intel.com
Subject: Re: lm sensors sysfs file structure
Message-ID: <20030403184342.GB1469@brodo.de>
References: <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com> <20030330192312.GB6666@zaurus.ucw.cz> <20030331224439.A7000@kroah.com> <20030401190240.GA6456@suse.de> <20030403002822.GB5130@kroah.com> <20030403104944.GB15633@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403104944.GB15633@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 11:49:44AM +0100, Dave Jones wrote:
> On Wed, Apr 02, 2003 at 04:28:22PM -0800, Greg KH wrote:
> 
>  > > FWIW, I'm taking the same fixed-point millivolt approach with the
>  > > sysfs overrides for cpufreq.  Having similar things in sysfs
>  > > exporting the same units seems to be a good idea.
>  > 
>  > Hm, in looking around the kernel some more, it seems that there are a
>  > number of other places that export voltage and temperature values (ACPI
>  > being one of the most obvious.)  It might be time to start thinking of a
>  > single userspace library to access all of these kinds of values in a
>  > system, instead of having to probe around different parts of the sysfs
>  > tree by hand...
> 
> Had occured to me too. There was talk of a libpower or the likes
> mentioned on acpi-devel a year or so back, but afaik nothing really
> came of it.

Actually, the "ospmd" tool (available at http://acpi.sourceforge.net )
already seems to manage APM and ACPI input. Well, and speaking of ACPI and 
sysfs in the same message: IMHO the /proc/acpi/ interface should be replaced
by something in /sysfs/ as well....

	Dominik
