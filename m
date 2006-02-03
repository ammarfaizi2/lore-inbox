Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWBCXGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWBCXGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWBCXGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:06:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30933 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751511AbWBCXGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:06:39 -0500
Date: Fri, 3 Feb 2006 15:06:16 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 0/3] NUMA slab locking fixes
In-Reply-To: <20060203140748.082c11ee.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
References: <20060203205341.GC3653@localhost.localdomain>
 <20060203140748.082c11ee.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Andrew Morton wrote:

> Could you please redo/retest these patches so that they apply on
> 2.6.16-rc2.  Also, please arrange for any bugfixes to be staged ahead of
> any optimisations - the optimisations we can defer until 2.6.17.

It seems that these two things are tightly connected. By changing the 
locking he was able to address the hotplug breakage.

