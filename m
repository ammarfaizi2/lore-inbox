Return-Path: <SRS0=sxH1=Z4=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E25AC43603
	for <io-uring@archiver.kernel.org>; Fri,  6 Dec 2019 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E782A24673
	for <io-uring@archiver.kernel.org>; Fri,  6 Dec 2019 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575660335;
	bh=I4tPPkfvhLshAyjTJeBy4FJCRBGCykaQm0xegKYnRlE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=a0DIDS9Va6bULJ7IEf+znpYtlNMuQruIFp2x1QuiOP+S0UPG40MDFzwM5wKzpbNmb
	 +04udVfIYBiSEiuZfA9TQIGELxJYJKNHQJfxaK8KXIWC68G9axBbhHFAYV1PdUXThP
	 F9tXwdszANRLsK4ZEKCoXK2TnXZZBaxqxkA2tm+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfLFTZe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfLFTZe (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 6 Dec 2019 14:25:34 -0500
Subject: Re: [GIT PULL] Block/io_uring fixes and changes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575660334;
        bh=I4tPPkfvhLshAyjTJeBy4FJCRBGCykaQm0xegKYnRlE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VBeVJwhBqkLvleMiRc8bfsqXDh6/a6mKFFYY4wkJWzx7myUi4KT/HLSgLiVyGEzQ6
         LOjQisO09T9bUaxEstk9l463xDk/4IgiEUtSj0G+RT7g5cyL13NDOOgcH+fP0Vur6r
         WHK3HmQQwruGpGMh+tczW7J1O0xrApvoi6hvDsbI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <01d2e4de-c834-dd52-e28d-3ff75ca5cd34@kernel.dk>
References: <01d2e4de-c834-dd52-e28d-3ff75ca5cd34@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <01d2e4de-c834-dd52-e28d-3ff75ca5cd34@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191205
X-PR-Tracked-Commit-Id: 8539429917c48c994d2e2cafa02ab06587b3b42c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9feb1af97e7366b512ecb9e4dd61d3252074cda3
Message-Id: <157566033397.16317.17317159585012617980.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 19:25:33 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Thu, 5 Dec 2019 19:23:25 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191205

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9feb1af97e7366b512ecb9e4dd61d3252074cda3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
