Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWA0A2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWA0A2D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWA0A2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:28:03 -0500
Received: from kanga.kvack.org ([66.96.29.28]:65449 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751340AbWA0A2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:28:01 -0500
Date: Thu, 26 Jan 2006 19:23:31 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
Message-ID: <20060127002331.GH10409@kvack.org>
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138233093.27293.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 03:51:33PM -0800, Matthew Dobson wrote:
> plain text document attachment (critical_mempools)
> Add NUMA-awareness to the mempool code.  This involves several changes:

This is horribly bloated.  Mempools should really just be a flag and 
reserve count on a slab, as then the code would not be in hot paths.

		-ben
