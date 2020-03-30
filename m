Return-Path: <SRS0=VaGm=5P=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F6C43331
	for <io-uring@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56C120784
	for <io-uring@archiver.kernel.org>; Mon, 30 Mar 2020 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585597828;
	bh=R6wDk2m111rH4CuDXMFzHcS4xBTUim+MIi8E7Eq/Jrc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ulk0R5xYroS/k8nMrEEHN306Wu6u1xRkZYyLzEPJyNOR+dgJ2kbMnvmb2ZSaJR5jL
	 6ejMOKY4vbZQh9KgiMIETxtfIUpJXdhf7OkIQeEHV6baCbXp6l4wJBvSDurOIcCcoS
	 nxCKjvj/rQfs3QxfJiGdHzFEB1b92Y2mr62z0qg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgC3Tu1 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgC3TuJ (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 30 Mar 2020 15:50:09 -0400
Subject: Re: [GIT PULL] io_uring updates for 5.7-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585597809;
        bh=R6wDk2m111rH4CuDXMFzHcS4xBTUim+MIi8E7Eq/Jrc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LbOquw/KmQAHUf4jtyPszTNxZTouNnWdpG8C2Rqb1oEiv342Y/UTkAT+wCmdc6Day
         mZKlw6OmxXB4fBifKr1jkIHp5lfO0t5Ok4UB3Aqmh2xGdBL5QW8F2rXCpaxBCxnCIY
         RH5NDKKz9bzGN+gHyNg5+W7leTrC/Bo7otLgI0Es=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <90978552-6746-1902-888b-4b6150e02b7a@kernel.dk>
References: <90978552-6746-1902-888b-4b6150e02b7a@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <90978552-6746-1902-888b-4b6150e02b7a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.7/io_uring-2020-03-29
X-PR-Tracked-Commit-Id: 3d9932a8b240c9019f48358e8a6928c53c2c7f6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e59cd88028dbd41472453e5883f78330aa73c56e
Message-Id: <158559780935.12131.16884371446285327934.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 19:50:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Sun, 29 Mar 2020 17:04:39 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.7/io_uring-2020-03-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e59cd88028dbd41472453e5883f78330aa73c56e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
