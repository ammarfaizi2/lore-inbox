Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268119AbTBSAub>; Tue, 18 Feb 2003 19:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268121AbTBSAua>; Tue, 18 Feb 2003 19:50:30 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6795
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268119AbTBSAu3>; Tue, 18 Feb 2003 19:50:29 -0500
Subject: Re: Select voltage manually in cpufreq
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de,
       linux@brodo.de
In-Reply-To: <20030218214726.GB15007@f00f.org>
References: <20030218214220.GA1058@elf.ucw.cz>
	 <20030218214726.GB15007@f00f.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045620140.25795.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 02:02:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 21:47, Chris Wedgwood wrote:
> On Tue, Feb 18, 2003 at 10:42:20PM +0100, Pavel Machek wrote:
> 
> > I've added possibility to manualy force specified frequency and
> > voltage... That's fairly usefull for testing, and I believe this (or
> > something equivalent) is needed because every 2nd bios seems to be
> > b0rken.
> 
> Why are all the power/cpu patches so complex?  Can't we have a
> two-mode style operation, "slow-low-power" and "fast-high-power" or
> something?  Would that not work with 99% or what people need and also
> be somewhat more uniform across platforms, CPUs, etc?

The ACPI side deals with most of that aspect of it. The low level stuff
is cool for some people, its there so you can have speed sliders, 
temperature gauges, flashing red thermal lights, watt meters and the
rest to go with your blue lights, see through case and watercooler ;)
 
