Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313319AbSC2ApD>; Thu, 28 Mar 2002 19:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313320AbSC2Aox>; Thu, 28 Mar 2002 19:44:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12816 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313319AbSC2Aon>; Thu, 28 Mar 2002 19:44:43 -0500
Date: Thu, 28 Mar 2002 19:42:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA356AE.2E61F712@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020328194003.19963B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Andrew Morton wrote:

> I'm not particularly fussed about this one, but I do prefer
> the sleep-at-night safety of a blanket memset.  Because
> (and I think this is something on which you and I somewhat
> differ) code should be written for the convenience of others,
> not the original author.  A nice memset will leave no doubt
> in the reader's mind that all members of the structure have
> been initialised.

  Definitely. It's easy to forget to initialize something when you reuse a
struct.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

