Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264332AbTLKBfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLKBdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:33:35 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:62894 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264301AbTLKBcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:32:43 -0500
Date: Wed, 10 Dec 2003 20:32:28 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>, <rl@hellgate.ch>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       <linux-kernel@vger.kernel.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031211012817.GQ14258@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0312102032030.25222-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003, William Lee Irwin III wrote:

> I could probably use some helpers to untangle it from the highpmd,
> compile-time mapping->page_lock rwlock/spinlock switching, RCU
> mapping->i_shared_lock, and O(1) proc_pid_statm() bits.

Looking into it.  Your patch certainly has a lot of stuff
folded into one piece ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

