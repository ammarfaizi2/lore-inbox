Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVKNSKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVKNSKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKNSKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:10:16 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:39660 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751217AbVKNSKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:10:15 -0500
Date: Mon, 14 Nov 2005 10:09:26 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, wli@holomorphy.com
Subject: Re: [RFC] NUMA memory policy support for HUGE pages
In-Reply-To: <1131980814.13502.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0511141007590.353@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511111051080.20589@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0511111225100.21071@schroedinger.engr.sgi.com>
 <1131980814.13502.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Adam Litke wrote:

> On Fri, 2005-11-11 at 12:28 -0800, Christoph Lameter wrote:
> > I just saw that mm2 is out. This is the same patch against mm2 with 
> > hugetlb COW support.
> 
> This all seems reasonable to me.  Were you planning to send out a
> separate patch to support MPOL_BIND?

MPOL_BIND will provide a zonelist with only the nodes allowed. This is 
included in the way the policy layer builds the zonelists.

