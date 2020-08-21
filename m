Return-Path: <SRS0=zR8S=B7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B40C433DF
	for <io-uring@archiver.kernel.org>; Fri, 21 Aug 2020 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8B220855
	for <io-uring@archiver.kernel.org>; Fri, 21 Aug 2020 22:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598047572;
	bh=OkedBb13B879EbTPYp2eycClVh6+FPw4+0oIze6n+oI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lwcFoOz3mWXdWDkg5cIFrnQGwcoXWE50YPiIUuf1MBTBCxsiHvdCSGqxAd//Z61RE
	 +WAT0aD8sNOGM+jBmaAyJYlyzQPjF0ik2Svpehn78zorJjqG3Q8iTDzxDyvPaV6jp+
	 cG6lwQcyuA1opmdt7tkXl88hljdHlGqZNLPZPUhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgHUWGL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHUWGL (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 21 Aug 2020 18:06:11 -0400
Subject: Re: [GIT PULL] io_uring fixes for 5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598047570;
        bh=OkedBb13B879EbTPYp2eycClVh6+FPw4+0oIze6n+oI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KWMuEWv6kpPiFpp0fJaDGFwpud65sXhRNZHPEOpveE/T9YGTlaIuQs3HThZ0AAr9l
         i55DdT/6VmZSAKmL0zvPR+I5MXkN9FN+eoHi1/MI1Enn9dwi14RABrkXliJDclK+LY
         +D7nZvyzBE/FngmInxnqKwp+hUOyUbSowDCslRwI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <82c089ee-4f2e-ad68-efb4-e90e3a0c543d@kernel.dk>
References: <82c089ee-4f2e-ad68-efb4-e90e3a0c543d@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <82c089ee-4f2e-ad68-efb4-e90e3a0c543d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-08-21
X-PR-Tracked-Commit-Id: 867a23eab52847d41a0a6eae41a64d76de7782a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f873db9acd3c92d4741bc3676c9eb511b2f9a6f6
Message-Id: <159804757070.4316.6604291751876525034.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Aug 2020 22:06:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 21 Aug 2020 14:53:38 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-08-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f873db9acd3c92d4741bc3676c9eb511b2f9a6f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
