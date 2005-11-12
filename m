Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVKLUtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVKLUtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVKLUtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:49:15 -0500
Received: from fsmlabs.com ([168.103.115.128]:16318 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S964795AbVKLUtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:49:15 -0500
X-ASG-Debug-ID: 1131828552-18236-63-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sat, 12 Nov 2005 12:54:57 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Nathan Lynch <nathanl@austin.ibm.com>, ashok.raj@intel.com,
       linux-kernel@vger.kernel.org, ak@muc.de, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, jschopp@austin.ibm.com,
       anil.s.keshavamurthy@intel.com
X-ASG-Orig-Subj: Re: Documentation for CPU hotplug support
Subject: Re: Documentation for CPU hotplug support
In-Reply-To: <20051111175953.7a5ce8dd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511121252460.1542@montezuma.fsmlabs.com>
References: <20051110075932.A16271@unix-os.sc.intel.com>
 <20051111072300.GY8977@localhost.localdomain> <20051111175953.7a5ce8dd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5240
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Andrew Morton wrote:

> Nathan Lynch <nathanl@austin.ibm.com> wrote:
> >
> >  Argh, no.  That current_in_cpuhotplug hack has to go.
> 
> Yes, Ashok is busily working on removing that ;)

Ashok was my patch for the cpufreq driver *that* horrible? Or perhaps we 
just need to move things like the set_cpus_allowed further up in the calls 
and handle everything in one location. Interested?

Thanks,
	Zwane

