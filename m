Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965629AbWKGR4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965629AbWKGR4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965326AbWKGR4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:56:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47812 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932769AbWKGR4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:56:16 -0500
Date: Tue, 7 Nov 2006 09:55:54 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, mm-commits@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <20061107093112.A3262@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0611070954210.3791@schroedinger.engr.sgi.com>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net>
 <20061107073248.GB5148@elte.hu> <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com>
 <20061107093112.A3262@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Siddha, Suresh B wrote:

> Christoph, DECLARE_TASKLET that you had atleast needs to be per cpu.. 
> Not sure if there are any other concerns.

Nope. Tasklets scheduled and executed per cpu. These are the former bottom 
halves. See tasklet_schedule in kernel/softirq.c


