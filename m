Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUJLPlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUJLPlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbUJLPlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:41:24 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23500 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265093AbUJLPlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:41:15 -0400
Date: Tue, 12 Oct 2004 08:38:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org
Subject: Re: NUMA: Patch for node based swapping
In-Reply-To: <1513170000.1097594210@[10.10.2.4]>
Message-ID: <Pine.LNX.4.58.0410120838100.12195@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com>
 <1513170000.1097594210@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Martin J. Bligh wrote:

> PS, might be possible to add a mechanism to ask kswapd to reclaim some
> cache pages without doing swapout, but I fear of messing with the delicate
> balance of the universe - cache vs user.

That is also my concern. I think the patch is useful to address the
immediate issue.

