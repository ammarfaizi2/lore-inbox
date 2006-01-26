Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWAZXPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWAZXPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWAZXPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:15:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:55985 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030203AbWAZXPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:15:51 -0500
Date: Thu, 26 Jan 2006 15:15:34 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
In-Reply-To: <43D953C4.5020205@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com>
References: <20060125161321.647368000@localhost.localdomain>
 <1138233093.27293.1.camel@localhost.localdomain>
 <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
 <43D953C4.5020205@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2006, Matthew Dobson wrote:

> Not all requests for memory from a specific node are performance
> enhancements, some are for correctness.  With large machines, especially as

alloc_pages_node and friends do not guarantee allocation on that specific 
node. That argument for "correctness" is bogus.

> > You do not need this.... 
> I do not agree...

There is no way that you would need this patch.


