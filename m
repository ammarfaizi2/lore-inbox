Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbTICSdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTICS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:29:40 -0400
Received: from holomorphy.com ([66.224.33.161]:46729 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264231AbTICSZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:25:40 -0400
Date: Wed, 3 Sep 2003 11:26:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903182645.GT4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <20030903181552.GF5769@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903181552.GF5769@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 11:15:50AM -0700, William Lee Irwin III wrote:
>> Independent operating system instances running under a hypervisor don't
>> qualify as a cache-coherent cluster that I can tell; it's merely dynamic
>> partitioning, which is great, but nothing to do with clustering or SMP.

On Wed, Sep 03, 2003 at 11:15:52AM -0700, Larry McVoy wrote:
> they can map memory between instances

That's just enough of a hypervisor API for the kernel to do the rest,
which it is very explicitly not doing. It also has other uses.


-- wli
