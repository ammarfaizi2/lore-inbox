Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUKSH5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUKSH5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUKSH5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:57:40 -0500
Received: from holomorphy.com ([207.189.100.168]:34186 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261290AbUKSH5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:57:38 -0500
Date: Thu, 18 Nov 2004 23:57:32 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1
Message-ID: <20041119075732.GO2268@holomorphy.com>
References: <20041116014213.2128aca9.akpm@osdl.org> <20041117113225.GP3217@holomorphy.com> <20041117123401.GQ3217@holomorphy.com> <20041117125624.GR3217@holomorphy.com> <20041118102210.GB3217@holomorphy.com> <20041118023123.4365de41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118023123.4365de41.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> sparc64 broke between 2.6.9 and 2.6.10-rc1. Are there any split-up
>> diffs of what went on between 2.6.9 and 2.6.10-rc1?

On Thu, Nov 18, 2004 at 02:31:23AM -0800, Andrew Morton wrote:
> That'll be hard to do, because 2.6.9->2.6.10-rc1 was one of those brief
> periods of frenetic patchbombing.
> You could try 2.6.9-rc4-mm1 and if the bug is there, try 2.6.9-rc4-mm1's
> linus.patch and if the bug is not there, iterate though 2.6.9-rc4-mm1's
> patches.
> If the bug isn't in 2.6.9-rc4-mm1 I guess you're down to a binary search
> with `bk clone'.  It might be a bit easier with bkcvs actually.

I got it narrowed down to the exact patch and bad interaction, then
davem spotted the right thing to do instantly, so this one's closed.


-- wli
