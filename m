Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVASGfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVASGfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVASGfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:35:44 -0500
Received: from fmr15.intel.com ([192.55.52.69]:45773 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261601AbVASGfi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:35:38 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Lmbench-users] Re: pipe performance regression on ia64
Date: Tue, 18 Jan 2005 22:35:27 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02BFFE3A@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lmbench-users] Re: pipe performance regression on ia64
Thread-Index: AcT91CXe4jWQ4F2WT2i/sKf2doQANwAAc32wAAarX0A=
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zou, Nanhai" <nanhai.zou@intel.com>, "Larry McVoy" <lm@bitmover.com>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: <davidm@hpl.hp.com>, <carl.staelin@hp.com>, <lmbench-users@bitmover.com>,
       <linux-ia64@vger.kernel.org>,
       "Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jan 2005 06:35:29.0929 (UTC) FILETIME=[11B5CF90:01C4FDF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Maybe lmbench could add a feature that bw_pipe will fork CPU 
>number of children to measure the average throughput. 
>
>This will give a much reasonable result when running bw_pipe 
>on a SMP Box, at least for Linux.

bw_pipe (along with most/all of the lmbench tools already has
a "-P" argument to specify the degree of parallelism).

-Tony
