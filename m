Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWHaKXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWHaKXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWHaKXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:23:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10439 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751032AbWHaKXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:23:33 -0400
Date: Thu, 31 Aug 2006 03:21:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, nathanl@austin.ibm.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, ntl@pobox.com, y-goto@jp.fujitsu.com,
       anton@samba.org, haveblue@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH] cpuset: hotunplug cpus and mems in all cpusets
Message-Id: <20060831032132.74fd356e.pj@sgi.com>
In-Reply-To: <20060829060824.6621.28300.sendpatchset@jackhammer.engr.sgi.com>
References: <20060829060824.6621.28300.sendpatchset@jackhammer.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton or Nathan - did you get a chance to test this patch?

I finally got my hands on a hotplug capable system - just 4 CPUs and 1
memory node (SMP, not NUMA).  This patch plugged and unplugged CPUs ok
from what I could see, updating the cpuset 'cpus' files as intended.

I am confident it's a good patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
