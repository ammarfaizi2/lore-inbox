Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUDOK0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUDOK0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:26:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32621 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262080AbUDOK0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:26:15 -0400
Date: Thu, 15 Apr 2004 11:26:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <35840000.1082010202@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0404151122190.6954-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004, Martin J. Bligh wrote:
> 
> FYI, even without prio-tree, I get a 12% boost from converting i_shared_sem
> into a spinlock. I'll try doing the same on top of prio-tree next.

Good news, though not a surprise.

Any ideas how we might handle latency from vmtruncate (and
try_to_unmap) if using prio_tree with i_shared_lock spinlock?

Hugh

