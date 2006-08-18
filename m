Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWHRE41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWHRE41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 00:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWHRE41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 00:56:27 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:31114 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161000AbWHRE41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 00:56:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.16105.135503.273249@cargo.ozlabs.ibm.com>
Date: Fri, 18 Aug 2006 14:15:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
In-Reply-To: <20060817102030.f8c41330.pj@sgi.com>
References: <20060815175525.A2333@unix-os.sc.intel.com>
	<20060815212455.c9fe1e34.pj@sgi.com>
	<20060815214718.00814767.akpm@osdl.org>
	<20060816110357.B7305@unix-os.sc.intel.com>
	<20060817102030.f8c41330.pj@sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:

> My understanding is that the "cpu_power" of the cpus in a sched group
> is rougly proportional to the BogoMIPS of the CPUs in that group.

Uh oh, on powerpc the bogomips has nothing at all to do with the speed
of the cpu, but relates instead to the frequency at which the timebase
register counts...

Paul.
