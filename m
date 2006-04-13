Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWDMXp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWDMXp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWDMXp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:45:56 -0400
Received: from ns.suse.de ([195.135.220.2]:28108 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965050AbWDMXp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:45:56 -0400
Date: Thu, 13 Apr 2006 16:44:52 -0700
From: Greg KH <gregkh@suse.de>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 13/22] edac_752x needs CONFIG_HOTPLUG
Message-ID: <20060413234452.GA7939@suse.de>
References: <20060413230141.330705000@quad.kroah.org> <20060413230835.GN5613@kroah.com> <200604131625.09829.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604131625.09829.dsp@llnl.gov>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:25:09PM -0700, Dave Peterson wrote:
> On Thursday 13 April 2006 16:08, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> >
> > ------------------
> >
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > EDAC_752X uses pci_scan_single_device(), which is only available
> > if CONFIG_HOTPLUG is enabled, so limit this driver with HOTPLUG.
> >
> > This patch was already included in Linus' tree.
> >
> > Adrian Bunk:
> > Rediffed for 2.6.16.x due to unrelated context changes.
> >
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Signed-off-by: David S. Peterson <dsp@llnl.gov>

Thanks, I've added this.

greg k-h
