Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUDORDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbUDORDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:03:38 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:36573 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264356AbUDORDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:03:37 -0400
Date: Thu, 15 Apr 2004 10:14:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <178970000.1082049291@flay>
In-Reply-To: <Pine.LNX.4.44.0404151752210.9569-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404151752210.9569-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Any ideas how we might handle latency from vmtruncate (and
>> > try_to_unmap) if using prio_tree with i_shared_lock spinlock?
>> 
>> I've been thinking about that. My rough plan is to go wild, naked and lockless.
>> If we arrange things in the correct order, new entries onto the list would
> 
> It's quite easy if there's a list - though I'm not that eager to go wild,
> naked and lockless with you!  But what if there's a prio_tree?

I still think my list-of-lists patch fixes the original problem, and is
simpler ... I'll try to get it updated, and sent out.

M.,

