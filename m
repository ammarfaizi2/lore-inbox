Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFZNVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTFZNVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:21:01 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:14090 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261292AbTFZNU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:20:59 -0400
Date: Thu, 26 Jun 2003 15:22:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel patch release checklist available
Message-ID: <20030626132254.GA27843@alpha.home.local>
References: <16122.53870.710841.141793@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16122.53870.710841.141793@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 09:01:02PM +1000, Peter Chubb wrote:
> 
> After being burnt a few times in forgetting something that I should
> have done when releasing a patch against the kernel, I've created a
> Kernel Patch Release Checklist at
> 
> http://www.gelato.unsw.edu.au/IA64wiki/PatchReleaseChecklist 

Good idea. I think this should go into the Documentation directory.
I would personnaly add :
- "1.4.3 have you described side-effects you're aware of, or incompatibilities
  or breakage of other patches ?"
- "1.5.2. Have you checked that your patch still applies without fuzz on latest
dev kernel ?" (which is not implied nor excused by 1.4.2).

Cheers,
Willy

