Return-Path: <SRS0=uKFK=AA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A1C433E0
	for <io-uring@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA5C20776
	for <io-uring@archiver.kernel.org>; Fri, 19 Jun 2020 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592598324;
	bh=v9zrPDmmswWMFJiTd19uZrE+lOTh3PoYNyxBHnXZPnU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=h92Pjlw7DL/NcG3b2QNiA6cpgcyCp9MIpStyoKihk6GiwwaRWrdA5H4fnCoTjbMES
	 UK5h5VbcuRTvbK5ZRTsvAZi7qKgSboflFPoL4rl61RIE5QqAW0rHj0vEKHPQUp5yQt
	 ghgMpEkzkniT/wyjY1gtUkFsL8eRO2kjjQXchIEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbgFSUZY (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388005AbgFSUZX (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 19 Jun 2020 16:25:23 -0400
Subject: Re: [GIT PULL] io_uring fixes for 5.8-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592598323;
        bh=v9zrPDmmswWMFJiTd19uZrE+lOTh3PoYNyxBHnXZPnU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FpijoVfnNtysReCWoB9lhYitzqGO+woyXL8KGwBS7ocNGgpNJb7a99owcVmFqh2el
         kAVwdYdfz3Rrf5K+kB7u8kpDxTub7JLqqECUpgDbw+YwSq5m0FEnkNSnn8r7Km20hV
         6GV5brv3v/7199Eegb2YJH0pvTmD3rogWtX0eicQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bf5c364b-aaf4-ed48-4f52-07304d6e732b@kernel.dk>
References: <bf5c364b-aaf4-ed48-4f52-07304d6e732b@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bf5c364b-aaf4-ed48-4f52-07304d6e732b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/io_uring-5.8-2020-06-19
X-PR-Tracked-Commit-Id: 6f2cc1664db20676069cff27a461ccc97dbfd114
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
Message-Id: <159259832340.1498.17715728828431679039.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jun 2020 20:25:23 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 19 Jun 2020 08:58:23 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.8-2020-06-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4333a9b0b67bb4e8bcd91bdd80da80b0ec151162

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
