Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758553AbWK2BJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758553AbWK2BJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758554AbWK2BJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:09:30 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:23512 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1758553AbWK2BJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:09:29 -0500
Date: Tue, 28 Nov 2006 17:08:51 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Tuttle <thinkinginbinary@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       James Ketrenos <jketreno@linux.intel.com>
Subject: Re: 2.6.19-rc6-mm2
Message-ID: <20061129010851.GA29432@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061128020246.47e481eb.akpm@osdl.org> <20061129002411.GA1178@lion> <20061128165828.54208bc1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128165828.54208bc1.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 04:58:28PM -0800, Andrew Morton wrote:
> On Tue, 28 Nov 2006 19:24:45 -0500
> Thomas Tuttle <thinkinginbinary@gmail.com> wrote:
> 
> > 2. I'm not sure if this bug is in the kernel, wireless tools, or the
> > ipw3945 driver, but I haven't changed the version of anything but the
> > kernel.  When I do `iwconfig eth1 essid foobar' something drops the
> > last character of the essid, and a subsequent `iwconfig eth1' shows
> > "fooba" as the essid.  And it's actually set as "fooba", since I had
> > to do `iwconfig eth1 essid MyUsualEssid_' (note underscore) to get on
> > to my usual network.
> 
> This could be version skew between the wireless APIs in the kernel.org kernel,
> the wireless userspace, the out-of-tree ipw3945 driver and conceivably one
> of the git trees in -mm (although I suspect not the latter).
> 
> I don't know, but I know who to cc ;)   Probably they will want to knwo which
> version of wireless-tools userspace you are running.

	Yes, it's a problem because the driver is out-of-tree. I sent
a patch to the maintainer to make the driver compatible with kernel
before/after, and it's actually integrated in the version 1.1.2 of the
driver (Nov 1st).
	So, please upgrade your driver and tell us how it works...

	Jean

