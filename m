Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7F5C432BE
	for <io-uring@archiver.kernel.org>; Tue, 31 Aug 2021 02:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D9A61004
	for <io-uring@archiver.kernel.org>; Tue, 31 Aug 2021 02:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhHaC70 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239317AbhHaC70 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 30 Aug 2021 22:59:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9C23F61004;
        Tue, 31 Aug 2021 02:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630378711;
        bh=nsGIPinlH5h/JDi1gy6Eve4ENDYJPYs8DA2FJi2z3E8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TzjijQp3505tf5eIRupQDGQeVNzXq3fNbo5ktO3a4PIHVsv4s9B5jnYPBHANVP/S3
         CewSu66Y5OOWAFv+tm/cwcrM1kzpNHGhYvu+DMD+b3f8e3UAuvi8mJWPirLqlE+hwF
         a9NE9ZI23Ijpbqf1gTz9RFhAVEfwq+aFnaJ8/4b7fbUF95fs7NOytuo1yMJKxqi907
         EDmYZV7iIsFmFHjfpJ4o4O6Uw6R2cg7vZIVemKo2+RCBYcVu6fDB/cwlBJbsG2vjQT
         61VT5QsWtBcuZ9D8bNaqE5ERw3//xS3owAi3ans/SyVnT/XdKd2sV0dODdh8cNGvye
         lXPYWOHRGcNvA==
Subject: Re: [GIT PULL] bio recycling support
From:   pr-tracker-bot@kernel.org
In-Reply-To: <baf16ffa-1c31-95e8-dae5-ac4b98ee984a@kernel.dk>
References: <baf16ffa-1c31-95e8-dae5-ac4b98ee984a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <baf16ffa-1c31-95e8-dae5-ac4b98ee984a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-bio-cache.5-2021-08-30
X-PR-Tracked-Commit-Id: 3d5b3fbedad65088ec079a4c4d1a2f47e11ae1e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b629f8d6dc04d3af94429c18fe17239d6fbe2c3
Message-Id: <163037871151.18446.12415632165848863516.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 02:58:31 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 08:57:41 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-bio-cache.5-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b629f8d6dc04d3af94429c18fe17239d6fbe2c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
