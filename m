Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTLPAR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTLPAR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:17:29 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:64508 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264272AbTLPAR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:17:27 -0500
Date: Mon, 15 Dec 2003 19:17:12 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <wli@holomorphy.com>,
       <kernel@kolivas.org>, <chris@cvine.freeserve.co.uk>,
       <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
In-Reply-To: <20031215155427.6faff1d8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0312151914370.8735-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, Andrew Morton wrote:

> It could well be that something is simply misbehaving in there

I have my suspicions about inter-zone balancing in 2.6.

Something seems wrong, but I can't quite put my finger
on it yet.  This should have quite some impact in the
1 - 4 GB range and a test (done by somebody else, I can't
give you the details yet unfortunately) has shown there
is a problem.

I'm working on it and should come up with a patch soon.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

