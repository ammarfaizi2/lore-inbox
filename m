Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1644AC4320A
	for <io-uring@archiver.kernel.org>; Tue, 31 Aug 2021 02:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCFC60FED
	for <io-uring@archiver.kernel.org>; Tue, 31 Aug 2021 02:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhHaC73 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239419AbhHaC71 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 30 Aug 2021 22:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C77826101C;
        Tue, 31 Aug 2021 02:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630378712;
        bh=Ddk8H9FPeTAK0Mq2KxsbFZ5E2G6LygnM6tg0oDOLwks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ecFy0XHGvUl7aswofWVVpGobORI7MqVa/alRciwBtnHPGE09eJgBQ7XsA9fbyaevt
         XLz0n4wVKqpkCNxNAUviRUrsa/UVJ//B2f8l6oTBrfbixqncVA2thcdcOnJVuh7alO
         rkXjbQyyARSxB+NucmI7caViATU/qGJaPIOzvGwyDtpZa2nw4MUqXdl/GztnSJ4h/V
         tXCorqBBfMHnWgfssVwTlzu8J+n/kFZf7MywS1W2ln9O1W5fTaLh5iKJTapWgWVd84
         pfnq+CA5dA3vvXyEqXUg5XFY/UkP4Aq1aVmIU9Gfc3jRqJJKLvvzZq9FTd0bbZy6nS
         KEck/6L0tlnVQ==
Subject: Re: [GIT PULL] io_uring mkdirat/symlinkat/linkat support
From:   pr-tracker-bot@kernel.org
In-Reply-To: <13fee4ce-eb96-2297-8a68-ff33f76684c8@kernel.dk>
References: <13fee4ce-eb96-2297-8a68-ff33f76684c8@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <13fee4ce-eb96-2297-8a68-ff33f76684c8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.15/io_uring-vfs-2021-08-30
X-PR-Tracked-Commit-Id: cf30da90bc3a26911d369f199411f38b701394de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b91db6a0b52e019b6bdabea3f1dbe36d85c7e52c
Message-Id: <163037871277.18446.5359580197495012776.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 02:58:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Dmitry Kadashev <dkadashev@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 09:00:26 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.15/io_uring-vfs-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b91db6a0b52e019b6bdabea3f1dbe36d85c7e52c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
