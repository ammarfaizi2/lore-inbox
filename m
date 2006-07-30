Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWG3Qv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWG3Qv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWG3Qv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:51:57 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:456 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S1750807AbWG3Qv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:51:57 -0400
Date: Sun, 30 Jul 2006 18:51:38 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk, davej@redhat.com,
       venkatesh.pallipadi@intel.com, tony@atomide.com, akpm@osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: 2.6.17 -> 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on pentium4
Message-ID: <20060730165137.GA26511@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
	davej@redhat.com, venkatesh.pallipadi@intel.com, tony@atomide.com,
	akpm@osdl.org, cpufreq@lists.linux.org.uk
References: <20060730120844.GA18293@outpost.ds9a.nl> <20060730160738.GB13377@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730160738.GB13377@irc.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I have similar problem with cpufreq-nforce2 -- http://lkml.org/lkml/2006/7/7/234
>   I haven't do a git-bisect yet.

To recap, cpufreq died for at least two people (Tomasz Torcz and me) between
2.6.17 and 2.6.18-rc1. I've cc'd everybody who touched cpufreq according to
the shortlog.

Abundant details are in:

http://lkml.org/lkml/2006/7/30/87

New information is that I've narrowed it down from between 2.6.16.9 and
2.6.18-rc1 to between 2.6.17.7 (which works) and 2.6.18-rc1 (which doesn't).

The problem exists both with cpufreq as modules and staticly, and both with
P4 and nforce2.

Please let me know how I can help you solve this problem. I'll try a git
bisect but a lot of the cpufreq changes appear to be interrelated, so I'm
unsure if it will work.

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
