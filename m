Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSDOUrg>; Mon, 15 Apr 2002 16:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSDOUrf>; Mon, 15 Apr 2002 16:47:35 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:26669 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S313242AbSDOUrf>; Mon, 15 Apr 2002 16:47:35 -0400
Date: Mon, 15 Apr 2002 21:50:12 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: don't miss a preemption
In-Reply-To: <1018900705.857.26.camel@phantasy>
Message-ID: <Pine.LNX.4.21.0204152144320.1833-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 2002, Robert Love wrote:
> 
> This patch checks for need_resched in preempt_schedule after setting
> preempt_count back to zero, before returning.  The overhead is
> negligible and it is crucial to never miss a preemption opportunity.

I'm curious: why is it crucial to never miss a preemption opportunity?

Hugh

