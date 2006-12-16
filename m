Return-Path: <linux-kernel-owner+w=401wt.eu-S932518AbWLPSjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWLPSjj (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWLPSji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:39:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53913 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932518AbWLPSji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:39:38 -0500
Date: Sat, 16 Dec 2006 10:38:53 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       clameter@engr.sgi.com, apw@shadowen.org, Andrew Morton <akpm@osdl.org>,
       heiko.carstens@de.ibm.com, bob.picco@hp.com
Subject: Re: [PATCH][2.6.20-rc1-mm1] sparsemem vmem_map optimzed pfn_valid()
 [0/2]
In-Reply-To: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0612161038080.5044@schroedinger.engr.sgi.com>
References: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, KAMEZAWA Hiroyuki wrote:

> By this, we'll not access mem_section[] in usual ops.

Why do we need mem_section? We have a page table that fulfills the same 
role.
