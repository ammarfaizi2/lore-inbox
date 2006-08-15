Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWHOW4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWHOW4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWHOW4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:56:18 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:65272 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750793AbWHOW4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:56:18 -0400
Date: Tue, 15 Aug 2006 17:56:07 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>, Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Message-Id: <20060815225607.17433.32727.sendpatch@wildcat>
Subject: [PATCH 0/2] Latest shared page table patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the latest copy of the shared page table patches.  They're
slimmed down a lot and have better synchronization to guarantee no
race conditions.

They also do partial page sharing.  A vma can be any size and alignment
and have its page table shared as long as it's the only vma in the pte page.

Dave McCracken

------------------------

