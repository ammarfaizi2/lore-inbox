Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965594AbWKGRoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965594AbWKGRoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWKGRoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:44:39 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40387 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932784AbWKGRoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:44:37 -0500
Date: Tue, 7 Nov 2006 09:44:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: akpm@osdl.org, mm-commits@vger.kernel.org, nickpiggin@yahoo.com.au,
       suresh.b.siddha@intel.com, linux-kernel@vger.kernel.org
Subject: Re: + sched-use-tasklet-to-call-balancing.patch added to -mm tree
In-Reply-To: <20061107073248.GB5148@elte.hu>
Message-ID: <Pine.LNX.4.64.0611070943160.3791@schroedinger.engr.sgi.com>
References: <200611032205.kA3M5wmJ003178@shell0.pdx.osdl.net>
 <20061107073248.GB5148@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Ingo Molnar wrote:

> i'm not sure i get the point of this whole do-rebalance-in-tasklet idea. 
> A tasklet is global to the system. The rebalance tick was per-CPU. This 
> is not an equivalent change at all. What am i missing?

A tasklet runs per cpu. In many ways it is equivalent to an interrupt 
context just interrupts are enabled.


