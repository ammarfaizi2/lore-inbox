Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTGBRLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTGBRLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:11:30 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19128 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264248AbTGBRLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:11:13 -0400
Date: Wed, 02 Jul 2003 10:10:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, Mel Gorman <mel@csn.ul.ie>
cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <461030000.1057165809@flay>
In-Reply-To: <20030702171159.GG23578@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the major reason you didn't mention for remap_file_pages is the rmap
> avoidance. There's no rmap backing the remap_file_pages regions, so the
> overhead per task is reduced greatly and the box stops running oom
> (actually deadlocking for mainline thanks to the oom killer and NOFAIL
> default behaviour). 

Maybe I'm just taking this out of context, and it's twisting my brain,
but as far as I know, the nonlinear vma's *are* backed by pte_chains.
That was the whole problem with objrmap having to do conversions, etc.

Am I just confused for some reason? I was pretty sure that was right ...

M.

