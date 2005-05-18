Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVERBI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVERBI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVERBI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:08:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42902 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262043AbVERBIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:08:20 -0400
Date: Tue, 17 May 2005 18:07:42 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: NUMA aware slab allocator V2
In-Reply-To: <428A7E48.6060909@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505171807280.12337@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>
 <20050512000444.641f44a9.akpm@osdl.org> <Pine.LNX.4.58.0505121252390.32276@schroedinger.engr.sgi.com>
 <20050513000648.7d341710.akpm@osdl.org> <428A7E48.6060909@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Matthew Dobson wrote:

> Also, there is a similar loop for CPUs which should be replaced with
> for_each_online_cpu(i).
> 
> These for_each_FOO macros are cleaner and less likely to break in the
> future, since we can simply modify the one definition if the way to
> itterate over nodes/cpus changes, rather than auditing 100 open coded
> implementations and trying to determine the intent of the loop's author.

Ok. Done.

