Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTFEN4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbTFEN4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 09:56:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57862 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264682AbTFEN42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 09:56:28 -0400
Date: Thu, 5 Jun 2003 14:45:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org,
       acpi-support@lists.sourceforge.net
Subject: Re: sleep forever in ACPI mode S3
Message-ID: <20030605124544.GB3660@zaurus.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A847E96F24@orsmsx401.jf.intel.com> <Pine.GSO.4.10.10306041627070.2442-100000@catfish.lcs.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10306041627070.2442-100000@catfish.lcs.mit.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > echo 3 > /proc/acpi/sleep
> > >  appears to work correctly on my IBM Thinkpad X20 -- except that it's
> > >  impossible to wake the machine back up.
> [...]
> > Does it start to come back but then not make it, or is it just
> > unrevivifiable?
> 
> hard to tell, since the screen is off.  nothing i do has any *visible*
> effect on the machine.

Okay, look at code doing suspend, it
sets up events that should wake it...

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

