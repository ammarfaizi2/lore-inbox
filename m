Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWHYO4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWHYO4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWHYO4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:56:09 -0400
Received: from waste.org ([66.93.16.53]:19648 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1422649AbWHYOzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:55:33 -0400
Date: Fri, 25 Aug 2006 09:54:17 -0500
From: Matt Mackall <mpm@selenic.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [RFC] maximum latency tracking infrastructure
Message-ID: <20060825145417.GZ19707@waste.org>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org> <20060824225236.GT19707@waste.org> <44EEAD35.9050005@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EEAD35.9050005@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 09:56:37AM +0200, Arjan van de Ven wrote:
> Matt Mackall wrote:
> >On Thu, Aug 24, 2006 at 07:41:35PM +0200, Arjan van de Ven wrote:
> >>Subject: [RFC] maximum latency tracking infrastructure
> >>From: Arjan van de Ven <arjan@linux.intel.com>
> >>
> >>The patch below adds infrastructure to track "maximum allowable latency" 
> >>for power
> >>saving policies.
> >
> >Looks good. But it will also be important to have a user-level way to
> >report who is constraining us from power saving and by how much of a
> >margin.
> >
> 
> there is in the patch:
> 
> echo l > /proc/sysreq-trigger

Ahh, missed that. I suppose that'll suffice.

-- 
Mathematics is the supreme nostalgia of our time.
