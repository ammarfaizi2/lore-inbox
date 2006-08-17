Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWHQX4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWHQX4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWHQX4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:56:05 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:9319 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750719AbWHQX4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:56:04 -0400
Message-ID: <44E50210.4060102@bigpond.net.au>
Date: Fri, 18 Aug 2006 09:56:00 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@redhat.com,
       apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
References: <20060815175525.A2333@unix-os.sc.intel.com>	<20060815212455.c9fe1e34.pj@sgi.com>	<20060815214718.00814767.akpm@osdl.org>	<20060816110357.B7305@unix-os.sc.intel.com> <20060817102030.f8c41330.pj@sgi.com>
In-Reply-To: <20060817102030.f8c41330.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 17 Aug 2006 23:56:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
>>> Hope not.  To me, "computing power" means megaflops/sec, or Dhrystones
>>> (don't ask) or whatever.  If that's what "cpu_power" is referring to then
>>> the name is hopelessly ambiguous with peak joules/sec and a big renaming is
>>> due.
>> It refers to group's processing power. Perhaps "horsepower" is better term.
> 
> Well ... I don't think "horsepower" is a step in the right direction.
> 
> Andrew's point was over the word "power", not "cpu".  The term
> "cpu_power" suggested to him we were concerned with the power supply
> watts consumed by a group of CPUs.  Indeed, both those concerned with
> laptop battery lifetimes, and the air conditioning tonnage needed
> for big honkin NUMA iron might have reason to be concerned with the
> power consumed by CPUs.
> 
> Changing the word "cpu" to "horse", but keeping the word "power",
> does nothing to address Andrew's point.  Rather it just adds more
> confusion.  We are obviously dealing with CPUs here, not horses.
> 
> My understanding is that the "cpu_power" of the cpus in a sched group
> is rougly proportional to the BogoMIPS of the CPUs in that group.
> 

How about energy instead of power?  I.e. the CPU's capacity to do work.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
