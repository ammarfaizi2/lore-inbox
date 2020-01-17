Return-Path: <SRS0=u4oL=3G=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6867EC33C9E
	for <io-uring@archiver.kernel.org>; Fri, 17 Jan 2020 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4132072E
	for <io-uring@archiver.kernel.org>; Fri, 17 Jan 2020 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579291204;
	bh=BhSWmBzfCPPdrgrWzh8CgtIdppc8+ZKyTTGhC+Kn3ic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2if1WdnH4yL6ymYSy+sR/2sit8GXeOD1y0XAFKEm1AHtzALuQvXJOo0G3l2Xgvx3F
	 57RUYI45qWgrLvNSM4/JLoekHrHe4BoqYnkpeatfc+IUZHbR13PjUDhqZGYTnPcoea
	 UlSd7NNIZROm21nR+WnoXTUIl/OjK9fBbpDfIVXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgAQUAD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgAQUAD (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 17 Jan 2020 15:00:03 -0500
Subject: Re: [GIT PULL] io_uring fixes for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579291203;
        bh=BhSWmBzfCPPdrgrWzh8CgtIdppc8+ZKyTTGhC+Kn3ic=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g3S/zYwqzurmJW5IjTEupcMN3ADsiP7yFnljBg8/Pxt3mB4hUtHZsdoNyz9EhyqDi
         JXFAq+FELF16bwo5xDfLvUkhOePOkK6ccTsvntlwdPcjr4EhtH7wds2r01YHzArD+F
         3rq1JjXnCOffQrNfSHjbX2zipzsvNHQxUFyD6+Mg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <48229b93-5e4d-78a2-3171-021e2a87c99b@kernel.dk>
References: <48229b93-5e4d-78a2-3171-021e2a87c99b@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <48229b93-5e4d-78a2-3171-021e2a87c99b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/io_uring-5.5-2020-01-16
X-PR-Tracked-Commit-Id: 44d282796f81eb1debc1d7cb53245b4cb3214cb5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25e73aadf297d78cf528841795cd37bad8320642
Message-Id: <157929120315.30919.10911615195407990230.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 20:00:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 17 Jan 2020 07:33:15 -0700:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.5-2020-01-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25e73aadf297d78cf528841795cd37bad8320642

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
