Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVFEL2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVFEL2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 07:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVFEL2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 07:28:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:28124 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261551AbVFEL2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 07:28:42 -0400
Date: Sun, 5 Jun 2005 13:28:40 +0200
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Message-ID: <20050605112840.GX23831@wotan.suse.de>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <200506021950.35014.kernel-stuff@comcast.net> <20050603163010.GR23831@wotan.suse.de> <200506041440.09795.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506041440.09795.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There I complain :):) - There is something wrong with this timer stuff in rc5. 
> I earlier stated that running with rc5 + John's TOD patches makes the music 
> players play music fast. It actually happens with plain vanilla rc5 too. (I 
> was having 3-4 ?trees and some confusion when I earlier tested rc5 with 
> John's patches.)

Do you actually use pmtimer? Please send a dmesg log.

Also note that pmtimer does not even drive the timer interrupt,
just gettimeofday.

-Andi
