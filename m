Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWGaUj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWGaUj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWGaUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:39:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030214AbWGaUj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:39:26 -0400
Date: Mon, 31 Jul 2006 16:38:29 -0400
From: Dave Jones <davej@redhat.com>
To: bert hubert <bert.hubert@netherlabs.nl>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
       venkatesh.pallipadi@intel.com, tony@atomide.com, akpm@osdl.org,
       cpufreq@lists.linux.org.uk, len.brown@intel.com
Subject: Re: 2.6.17 -> 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on	pentium4
Message-ID: <20060731203829.GF4631@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	bert hubert <bert.hubert@netherlabs.nl>,
	Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
	linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
	venkatesh.pallipadi@intel.com, tony@atomide.com, akpm@osdl.org,
	cpufreq@lists.linux.org.uk, len.brown@intel.com
References: <20060730120844.GA18293@outpost.ds9a.nl> <20060730160738.GB13377@irc.pl> <20060730165137.GA26511@outpost.ds9a.nl> <44CCF556.2060505@linux.intel.com> <20060730184443.GA30067@outpost.ds9a.nl> <20060730190133.GD18757@redhat.com> <20060731070800.GA22205@outpost.ds9a.nl> <20060731162046.GA4631@redhat.com> <20060731185713.GA16797@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731185713.GA16797@outpost.ds9a.nl>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 08:57:13PM +0200, bert hubert wrote:
 > On Mon, Jul 31, 2006 at 12:20:46PM -0400, Dave Jones wrote:
 > 
 > > Your change in your previous mail makes sense to me though,
 > > so I'll commit it to cpufreq.git later today.
 > 
 > Do you think this will make 2.6.18? Otherwise any kernel with acpi_list
 > compiled in will have no frequency scaling, unless it supports scaling over
 > ACPI.

Yes, I'll queue it for .18

		Dave

-- 
http://www.codemonkey.org.uk
