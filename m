Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbTJJHib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbTJJHib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:38:31 -0400
Received: from holomorphy.com ([66.224.33.161]:47232 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262583AbTJJHi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:38:29 -0400
Date: Fri, 10 Oct 2003 00:40:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: YoshiyaETO <eto@soft.fujitsu.com>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       linux-kernel@vger.kernel.org,
       Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be
Subject: Re: 2.7 thoughts
Message-ID: <20031010074030.GB700@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	YoshiyaETO <eto@soft.fujitsu.com>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	linux-kernel@vger.kernel.org,
	Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
	Fabian.Frederick@prov-liege.be
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010063039.GA700@holomorphy.com> <047b01c38f00$60b34840$6a647c0a@eto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047b01c38f00$60b34840$6a647c0a@eto>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
>>> * hotplug motherboard & entire computer too I spose ;-)

> From: "William Lee Irwin III" <wli@holomorphy.com>
>> Um, this is worse than the above wrt. being too vague.

On Fri, Oct 10, 2003 at 04:30:27PM +0900, YoshiyaETO wrote:
> "Hotplug node" is a better explanation, I think.
> "Node" includes CPUs and/or Memory and/or some kind of IOs.
> And "Node" should be flexibly configurable also.

I don't see any reason to connect it with the notion of a node.

The main points of contention would appear to be cooperative vs.
forcible (where I believe cooperative is acknowledged as the only
feasible problem), and the potential connections with ZONE_HIGHMEM
wrt. constraints that would artificially introduce to 64-bit kernels.

The fact some systems would want to do whole nodes at a time with
some cpus and io buses in tandem is largely immaterial and doesn't
simplify, complicate, or otherwise affect the VM mechanics.

-- wli
