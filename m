Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30EC4338F
	for <io-uring@archiver.kernel.org>; Wed, 25 Aug 2021 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B890C6115A
	for <io-uring@archiver.kernel.org>; Wed, 25 Aug 2021 12:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbhHYMdk (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:33:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51274 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhHYMdk (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 25 Aug 2021 08:33:40 -0400
Received: from localhost (unknown [149.11.102.75])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 0DD1A4D0F1970;
        Wed, 25 Aug 2021 05:32:52 -0700 (PDT)
Date:   Wed, 25 Aug 2021 13:32:47 +0100 (BST)
Message-Id: <20210825.133247.1847208011519477744.davem@davemloft.net>
To:     asml.silence@gmail.com
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org, josh@joshtriplett.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, metze@samba.org
Subject: Re: [PATCH v4 1/4] net: add accept helper not installing fd
From:   David Miller <davem@davemloft.net>
In-Reply-To: <c57b9e8e818d93683a3d24f8ca50ca038d1da8c4.1629888991.git.asml.silence@gmail.com>
References: <cover.1629888991.git.asml.silence@gmail.com>
        <c57b9e8e818d93683a3d24f8ca50ca038d1da8c4.1629888991.git.asml.silence@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 25 Aug 2021 05:32:54 -0700 (PDT)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 25 Aug 2021 12:25:44 +0100

> Introduce and reuse a helper that acts similarly to __sys_accept4_file()
> but returns struct file instead of installing file descriptor. Will be
> used by io_uring.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: David S. Miller <davem@davemloft.net>
