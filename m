Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbTICSSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264179AbTICSQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:16:10 -0400
Received: from holomorphy.com ([66.224.33.161]:36489 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264191AbTICSOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:14:42 -0400
Date: Wed, 3 Sep 2003 11:15:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903181550.GR4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903180547.GD5769@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The lines of reasoning presented against tightly coupled systems are
>> grossly flawed. 

On Wed, Sep 03, 2003 at 11:05:47AM -0700, Larry McVoy wrote:
> [etc].
> Only problem with your statements is that IBM has already implemented all
> of the required features in VM.  And multiple Linux instances are running
> on it today, with shared disks underneath so they don't replicate all the
> stuff that doesn't need to be replicated, and they have shared memory 
> across instances.

Independent operating system instances running under a hypervisor don't
qualify as a cache-coherent cluster that I can tell; it's merely dynamic
partitioning, which is great, but nothing to do with clustering or SMP.


-- wli
