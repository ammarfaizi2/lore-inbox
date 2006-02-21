Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWBUXPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWBUXPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWBUXPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:15:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24706 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750771AbWBUXPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:15:09 -0500
Date: Tue, 21 Feb 2006 15:14:47 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [patch] Cache align futex hash buckets
In-Reply-To: <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0602211329410.21148@schroedinger.engr.sgi.com>
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au>
 <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Christoph Lameter wrote:

> It does if you essentially have a 4k cacheline (because you are doing NUMA 
> in software with multiple PCs....) and transferring control of that 
> cacheline is comparatively expensive.

Of course the above statement is a rather strong simplification of what is 
actually happening .... but I hope it helps.

