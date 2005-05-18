Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVERRuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVERRuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVERRt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:49:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17035 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262218AbVERRtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:49:19 -0400
Date: Wed, 18 May 2005 10:48:37 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Christoph Lameter <christoph@lameter.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <428B7B16.10204@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Matthew Dobson wrote:

> Thanks!  I just looked at V2 & V3 of the patch and saw some open-coded
> loops.  I may have missed a later version of the patch which has fixes.
> Feel free to CC me on future versions of the patch...

I will when I get everything together. The hold up at the moment is that 
Martin has found a boot failure with the new slab allocator on ppc64 that 
I am unable to explain.
 
Strangely, the panic is in the page allocator. I have no means of 
testing since I do not have a ppc64 system available. Could you help me 
figure out what is going on?

