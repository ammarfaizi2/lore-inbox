Return-Path: <SRS0=oBCy=7Y=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D130C433DF
	for <io-uring@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23BFB2074B
	for <io-uring@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591919134;
	bh=rh++QD3no6/c2Rn8xTt0Lqp/lXa3+BKDFfk10RqPw6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hlja7WiNjUGM35W8ZMQHEWg5nTbkwHyVGLmV3lLLiUQCNS3oNf53sJhOp7l9zIACT
	 ohhBJEgJ2QaKsO9hHd4yS7wTitQPo8YEzggznLgZcFe59E0b9kPqjiC70lTw5u+k0M
	 jAwQk1IGmKfgyQ6ShOoI2YqBhjc7ZovtU7PdMHKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFKXp2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:45:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgFKXpZ (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Thu, 11 Jun 2020 19:45:25 -0400
Subject: Re: [GIT PULL] io_uring fixes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591919124;
        bh=rh++QD3no6/c2Rn8xTt0Lqp/lXa3+BKDFfk10RqPw6I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M1s1FOMRfM0SqKtqBnNAmq9hB+0f/D7YbTLG7SzksfQGaXg3vCy61ArvKF2CmAEce
         jfyEj70rSVis7bOTAxoIYb5yGWZc7UIGlimxIhhiHknKmuNWvvAtSMZK/JnKbdokdK
         b1/tpYrgNGoym0FCBwumH98TOkvVcU2nnfkpwKTc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <75aa6bc8-488a-07dd-feea-545500e51966@kernel.dk>
References: <75aa6bc8-488a-07dd-feea-545500e51966@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <75aa6bc8-488a-07dd-feea-545500e51966@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/io_uring-5.8-2020-06-11
X-PR-Tracked-Commit-Id: 65a6543da386838f935d2f03f452c5c0acff2a68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b961f8dc8976c091180839f4483d67b7c2ca2578
Message-Id: <159191912451.19194.10586193761310545264.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jun 2020 23:45:24 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Thu, 11 Jun 2020 15:35:22 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.8-2020-06-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b961f8dc8976c091180839f4483d67b7c2ca2578

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
