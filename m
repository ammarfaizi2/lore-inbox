Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVASDYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVASDYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 22:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVASDYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 22:24:41 -0500
Received: from fmr17.intel.com ([134.134.136.16]:58092 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261544AbVASDYg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 22:24:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Lmbench-users] Re: pipe performance regression on ia64
Date: Wed, 19 Jan 2005 11:24:20 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE74270013E8A01@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lmbench-users] Re: pipe performance regression on ia64
Thread-Index: AcT91CXe4jWQ4F2WT2i/sKf2doQANwAAc32w
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Larry McVoy" <lm@bitmover.com>, "Linus Torvalds" <torvalds@osdl.org>
Cc: <davidm@hpl.hp.com>, <carl.staelin@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, <lmbench-users@bitmover.com>,
       <linux-ia64@vger.kernel.org>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jan 2005 03:24:20.0569 (UTC) FILETIME=[5D705C90:01C4FDD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-ia64-owner@vger.kernel.org
> [mailto:linux-ia64-owner@vger.kernel.org] On Behalf Of Larry McVoy
> Sent: Wednesday, January 19, 2005 11:05 AM
> To: Linus Torvalds
> Cc: davidm@hpl.hp.com; carl.staelin@hp.com; Luck, Tony;
> lmbench-users@bitmover.com; linux-ia64@vger.kernel.org; Kernel Mailing
List
> Subject: Re: [Lmbench-users] Re: pipe performance regression on ia64
> 
> I'm very unthrilled with the idea of adding stuff to the release
benchmark
> which is OS specific.  That said, there is nothing to say that you
can't
> grab the benchmark and tweak your own test case in there to prove or
> disprove your theory.
> 

Maybe lmbench could add a feature that bw_pipe will fork CPU number of
children to measure the average throughput. 

This will give a much reasonable result when running bw_pipe on a SMP
Box, at least for Linux.

Zou Nan hai
