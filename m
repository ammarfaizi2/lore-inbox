Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWAZRzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWAZRzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWAZRzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:55:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14026 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751347AbWAZRzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:55:04 -0500
Date: Thu, 26 Jan 2006 09:54:47 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
In-Reply-To: <1138233093.27293.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com>
References: <20060125161321.647368000@localhost.localdomain>
 <1138233093.27293.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2006, Matthew Dobson wrote:

> plain text document attachment (critical_mempools)
> Add NUMA-awareness to the mempool code.  This involves several changes:

I am not quite sure why you would need numa awareness in an emergency 
memory pool. Presumably the effectiveness of the accesses do not matter. 
You only want to be sure that there is some memory available right?

You do not need this.... 
