Return-Path: <SRS0=xUAb=DJ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD46C35257
	for <io-uring@archiver.kernel.org>; Fri,  2 Oct 2020 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1002072E
	for <io-uring@archiver.kernel.org>; Fri,  2 Oct 2020 21:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601675676;
	bh=crSohLd1Km5nkGlKuOBM2Z30ZjsE7aOTllf/8vwt6pk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TyZHyTxMzaJb6moQMuJONAVdx5bRtQgX8ERgmSEi5Y0PriHwb2a2SRNdDRTMBYK7H
	 O9OXQyq1uQs+wu/QrYO4BOL4FXSbrUa+YmW8jVLnqFPpSrmNToxo+BD/uDcLDbwbI+
	 YRy2n57jJgoNAyTTTeG323V/RaVL2nZLwue1lQME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgJBVyT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgJBVyR (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 2 Oct 2020 17:54:17 -0400
Subject: Re: [GIT PULL] io_uring fixes for 5.9-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601675657;
        bh=crSohLd1Km5nkGlKuOBM2Z30ZjsE7aOTllf/8vwt6pk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OZfqG0UOW1xVlJL3IEjjeYJgpocD13lt8mMLrXGzmi++4k6bNDtEtc2Um8juXoCne
         fiPAdEERifLKuMYgKCPkUGGZnCrKziXgDzthS3fWbYWyWMmk3O6ZeStpGKU8T7PFNq
         yXoZDQVkQvezj8kWqvDOcf8WCFobqJGBkDnPtHvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <06ed71bb-ed17-9621-d461-e189ce217d28@kernel.dk>
References: <06ed71bb-ed17-9621-d461-e189ce217d28@kernel.dk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <06ed71bb-ed17-9621-d461-e189ce217d28@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-10-02
X-PR-Tracked-Commit-Id: c8d317aa1887b40b188ec3aaa6e9e524333caed1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 702bfc891db162b99e880da78cc256dac14cfc7f
Message-Id: <160167565723.8763.5894803145938362727.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 21:54:17 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 2 Oct 2020 11:48:48 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.9-2020-10-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/702bfc891db162b99e880da78cc256dac14cfc7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
