Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272894AbTHKSFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:05:14 -0400
Received: from holomorphy.com ([66.224.33.161]:62121 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S272818AbTHKSEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:04:43 -0400
Date: Mon, 11 Aug 2003 11:05:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test3-mm1
Message-ID: <20030811180552.GG32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030809203943.3b925a0e.akpm@osdl.org> <94490000.1060612530@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94490000.1060612530@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 07:35:31AM -0700, Martin J. Bligh wrote:
> Degredation on kernbench is still there:
> Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>                               Elapsed      System        User         CPU
>               2.6.0-test3       45.97      115.83      571.93     1494.50
>           2.6.0-test3-mm1       46.43      122.78      571.87     1496.00
> Quite a bit of extra sys time. I thought the suspected part of the sched
> changes got backed out, but maybe I'm just not following it ...

Is this with or without the unit conversion fix for the load balancer?

It will be load balancing extra-aggressively without the fix.


-- wli
