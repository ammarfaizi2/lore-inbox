Return-Path: <SRS0=enxk=4Q=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A09FC3F2D2
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 19:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4BA24672
	for <io-uring@archiver.kernel.org>; Fri, 28 Feb 2020 19:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582919707;
	bh=mmkTpMKMvD5ZKIpItKcqhfiMsfM9XYVXbaApKvjMAtI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hjAIK6zd+KL/EcHYUAQE+CsdXqjrCq5M7nHi77UvavpCN1aRMO7O9IS1ODEC7gmTf
	 e6zlKTJbCXS/tuD9mXosdrex/NzbyzeGu6FjvbxX0nGTqE5XzQCU5DYqzmCnHidHZW
	 Yvsyhho5urU++T9swd32IaL2I4DcR+TSxlUf1UNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgB1TzG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:55:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1TzG (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 28 Feb 2020 14:55:06 -0500
Subject: Re: [GIT PULL] io_uring fixes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582919706;
        bh=mmkTpMKMvD5ZKIpItKcqhfiMsfM9XYVXbaApKvjMAtI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Oj+lWwWJuneie/GOj5HCz/SFSFOC7Lvnya25poss/u6+zLSTzjKNl9IoX9koMdbft
         LrH43GkQ3nFlK1mZdH/xO6dtMmWqObNGvnSNuDKRgpSLUegMVNRIIqqj+8rYwKvlNN
         ku0/xlTR94AS9bi91ptVOXLs0+Btffsk5ZNlFIKs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d91f851a-97e6-cb5f-23f6-3de0ce93e4dc@kernel.dk>
References: <d91f851a-97e6-cb5f-23f6-3de0ce93e4dc@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d91f851a-97e6-cb5f-23f6-3de0ce93e4dc@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/io_uring-5.6-2020-02-28
X-PR-Tracked-Commit-Id: d876836204897b6d7d911f942084f69a1e9d5c4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74dea5d99d19236608914d2c556134e4cdc21c60
Message-Id: <158291970618.11737.6427067552350023714.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 19:55:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 11:42:44 -0700:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.6-2020-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74dea5d99d19236608914d2c556134e4cdc21c60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
