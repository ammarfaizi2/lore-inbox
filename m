Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWGaREk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWGaREk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWGaREk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:04:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43728 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030255AbWGaREj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:04:39 -0400
Date: Mon, 31 Jul 2006 10:04:25 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       suresh.b.siddha@intel.com, Simon.Derr@bull.net, steiner@sgi.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] sched: big numa dynamic sched domain memory corruption
Message-Id: <20060731100425.65432d31.pj@sgi.com>
In-Reply-To: <20060731090440.A2311@unix-os.sc.intel.com>
References: <20060731070734.19126.40501.sendpatchset@v0>
	<20060731071242.GA31377@elte.hu>
	<20060731090440.A2311@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Paul can you please test the mainline code and confirm?

This will take me a few hours - it requires a bit of
slab debugging scaffolding to detect the memory corruption
in a timely and accurate manner.  I'll have to port that
scaffolding forward from its current SLES10 base.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
