Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWBVDll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWBVDll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 22:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWBVDll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 22:41:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65513 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751325AbWBVDlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 22:41:40 -0500
Date: Tue, 21 Feb 2006 19:41:20 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: Christoph Lameter <clameter@engr.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove zone_mem_map
In-Reply-To: <43FBD995.20601@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0602211939210.26289@schroedinger.engr.sgi.com>
References: <43FBAEBA.2020300@jp.fujitsu.com>
 <Pine.LNX.4.64.0602211900450.23557@schroedinger.engr.sgi.com>
 <43FBD995.20601@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, KAMEZAWA Hiroyuki wrote:

> BTW, ia64 looks very special. Does it make sensible performance gain ?

Well yes, we actually have virtual mappings in kernel address space. 
F.e. The hotplug remove issues could be fixed there by remapping pages.
