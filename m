Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVBQTcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVBQTcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVBQTXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:23:13 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:2797 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262356AbVBQTS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:18:29 -0500
Date: Thu, 17 Feb 2005 13:18:26 -0600
From: Chris Larson <kergoth@handhelds.org>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Message-ID: <20050217191826.GB14147@rikers.org>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net> <20050217183709.GA11929@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217183709.GA11929@ncsu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jlnance@unity.ncsu.edu (jlnance@unity.ncsu.edu) wrote:
> On Mon, Feb 14, 2005 at 08:17:25PM -0500, Lee Revell wrote:
> 
> > from user space to presenting a login prompt that's way too long.  My
> > distro (Debian) runs all the init scripts one at a time, and GDM is the
> > last thing that gets run.  There is just no reason for this.  We should
> > start X and initialize the display and get the login prompt up there
> > ASAP, and let the system acquire the DHCP lease and start sendmail and
> > apache and get the date from the NTP server *in the background while I
> > am logging in*.  It's not rocket science.
> 
> This is debatable.  Windows does something like this.  It really annoys
> me that I will get a windows desktop very quickly after logging in
> but that I can't do anything with it until some mystrey initialization
> takes place.  I would hate to be able to log into my linux machine but
> not be able to check email for the first 15 seconds.

Wouldn't it be sufficient to have an applet in your UI (or dialog,
depending on your preference), which communicates with init and displays
the final initialization steps?  Don't check your email until it says it has
started the services for email.
--
Chris Larson - kergoth at handhelds dot org
Linux Software Systems Engineer - clarson at ti dot com
Core Developer/Architect - BitBake, OpenEmbedded, OpenZaurus
