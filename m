Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTIDA6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTIDA6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:58:34 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:36992 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264378AbTIDA6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:58:32 -0400
Date: Wed, 3 Sep 2003 17:58:22 -0700
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030904005822.GC5227@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903215135.GY4306@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 02:51:35PM -0700, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> >>  SSI clusters have most of the same problems,
> >>  really. Managing the systems just becomes "managing the nodes" because
> >>  they're not called systems, and you have to go through some (possibly
> >>  automated, though not likely) hassle to figure out the right way to
> >>  spread things across nodes, which virtualizes pieces to hand to which
> >>  nodes running which loads, etc.
> 
> On Wed, Sep 03, 2003 at 02:29:01PM -0700, Martin J. Bligh wrote:
> > That's where I disagree - it's much easier for the USER because an SSI
> > cluster works out all the load balancing shit for itself, instead of
> > pushing the problem out to userspace. It's much harder for the KERNEL
> > programmer, sure ... but we're smart ;-) And I'd rather solve it once,
> > properly, in the right place where all the right data is about all
> > the apps running on the system, and the data about the machine hardware.
> 
> This is only truly feasible when the nodes are homogeneous. They will
> not be as there will be physical locality (esp. bits like device
> proximity) concerns. 

Huh?  The nodes are homogeneous.  Devices are either local or proxied.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
