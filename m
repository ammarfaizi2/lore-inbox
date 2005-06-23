Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVFWI2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVFWI2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbVFWIW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:22:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:58558 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262601AbVFWHNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:13:55 -0400
Date: Thu, 23 Jun 2005 09:13:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: "'Pavel Machek'" <pavel@ucw.cz>, "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Message-ID: <20050623071345.GA4553@ucw.cz>
References: <20050622104927.GB2561@openzaurus.ucw.cz> <001201c57729$0a645840$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201c57729$0a645840$600cc60a@amer.sykes.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 06:50:59AM -0600, Alejandro Bonilla wrote:
> 
> > Hi!
> >
> > > > I'm trying to do watch -n1 cat /proc/acpi/ibm/ecdump, But
> > I don't have
> > > > ecdump. I'm with ibm-acpi 0.8
> > > >
> > >
> > > I was thinking more along the lines of figure out the io port it's
> > > using, then boot windows, set an IO breakpoint in softice, then drop
> > > your laptop on the bed or something.
> >
> > It should be enough to tilt your laptop so that it parks
> > heads... safer than
> > dropping it.
> >
> > And perhaps easier solution is to locate the sensor on the
> > mainboard, and
> > trace where it is connected with magnifying glass (as vojtech
> > already suggested).
> >
> > 				Pavel
> >
> > --
> > 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51
> > time=448769.1 ms
> >
> 
> /proc/acpi/ibm/ecdump is really not providing any information about this
> sensor. yesterday, I almost broke the laptop to see if it would generate
> anything, but it really only outputs ACPI events...
> 
> I shaked it, moved it 90deg and still no result, threw the lappy from like
> 40cm to the bed and nothing was really generated. Unless it is too fast like
> to generate it in the watch or to be seen by human eye. I dunno.
> 
> It looks like /ecdump won't do it.
 
But that doesn't mean it's not connected to the embedded controller. It
just means the embedded controller doesn't generate any inertial events
by itself - it may have to be polled with some specific command.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
