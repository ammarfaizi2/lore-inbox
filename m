Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTICTzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbTICThp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:37:45 -0400
Received: from holomorphy.com ([66.224.33.161]:18314 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264116AbTICTfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:35:39 -0400
Date: Wed, 3 Sep 2003 12:36:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, karim@opersys.com
Subject: Re: Scaling noise
Message-ID: <20030903193610.GV4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Steven Cole <elenstev@mesatop.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org, karim@opersys.com
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <1062616315.1816.22.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062616315.1816.22.camel@spc9.esa.lanl.gov>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 12:00, William Lee Irwin III wrote:
>> So as best as I can tell the proposal consists of using an orders-of-
>> magnitude slower communication method to implement an underspecified
>> solution to some research problem that to all appearances will be more
>> expensive to maintain and keep running than the now extant designs.

On Wed, Sep 03, 2003 at 01:11:55PM -0600, Steven Cole wrote:
> You and Larry are either talking past each other, or perhaps it is I who
> don't understand the not-yet-existing CC-clusters.  My understanding is
> that communication between nodes of a CC-cluster would be through a
> shared-memory mechanism, not through much slower I/O such as a network
> (even a very fast network).
> From Karim Yaghmour's paper here:
> http://www.opersys.com/adeos/practical-smp-clusters/
> "That being said, clustering packages may make assumptions that do not
> hold in the current architecture. Primarily, by having nodes so close
> together, physical network latencies and problems disappear."

The communication latencies will get better that way, sure.


On Wed, Sep 03, 2003 at 01:11:55PM -0600, Steven Cole wrote:
>> I like distributed systems and clusters, and they're great to use for
>> what they're good for. They're not substitutes in any way for tightly
>> coupled systems, nor do they render large specimens thereof unnecessary.

On Wed, Sep 03, 2003 at 01:11:55PM -0600, Steven Cole wrote:
> My point is this: Currently at least one vendor (SGI) wants to scale the
> kernel to 128 CPUs.  As far as I know, the SGI Altix systems can be
> configured up to 512 CPUs.  If the Intel Tanglewood really will have 16
> cores per chip, very much larger systems will be possible.  Will you be
> able to scale the kernel to 2048 CPUs and beyond?  This may happen
> during the lifetime of 2.8.x, so planning should be happening either now
> or soon.

This is not particularly exciting (or truthfully remotely interesting)
news. google for "BBN Butterfly" to see what was around ca. 1988.


-- wli
