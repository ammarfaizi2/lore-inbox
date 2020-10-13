Return-Path: <SRS0=eaUW=DU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E67C433DF
	for <io-uring@archiver.kernel.org>; Tue, 13 Oct 2020 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C140620E65
	for <io-uring@archiver.kernel.org>; Tue, 13 Oct 2020 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602618426;
	bh=sW5bZSj9tXNTgpVwyA8x/XO2Sqlq+1zfVdZX2nc3rBI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zhjw2ZRNnP+q9LJyYbNZjXyow18UZO9GXhG4TAkF7mMwJjMXK6BFYpMvIhVMXH7Y+
	 IF/EYz7kAW56uDQMaE0qrD618D+zw+mHVvh65azRel7m3tGtICUSngQ760LcG/Ljol
	 VKYYl5S5QEX2YvZ+2N5fu484PMlACTHUKTkRJ+9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgJMTrG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 13 Oct 2020 15:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgJMTrF (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Tue, 13 Oct 2020 15:47:05 -0400
Subject: Re: [GIT PULL] io_uring updates for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602618425;
        bh=sW5bZSj9tXNTgpVwyA8x/XO2Sqlq+1zfVdZX2nc3rBI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GPpbsH2pWIVJWg5NIUyxPfQDWv84ElupYHKtWezcTURjxxvABEIfViwrPW4HXJwKM
         WdSE2Z1mS4Y1xQKig4Bk/fRCMdGKHZMxQQV6FuODzJWw0lPtA8EiLX6e+B5ueiiqwj
         0evmeOTvgWOLuat9Z9ndhe55n3qAoq/LXRdLJIUI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <36a6706d-73e1-64e7-f1f8-8f5ef246d3ea@kernel.dk>
References: <36a6706d-73e1-64e7-f1f8-8f5ef246d3ea@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <36a6706d-73e1-64e7-f1f8-8f5ef246d3ea@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.10-2020-10-12
X-PR-Tracked-Commit-Id: b2e9685283127f30e7f2b466af0046ff9bd27a86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ad4bf6ea1609fb539a62f10fca87ddbd53a0315
Message-Id: <160261842542.30654.6149498732103217495.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 19:47:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 07:46:45 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.10-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ad4bf6ea1609fb539a62f10fca87ddbd53a0315

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
