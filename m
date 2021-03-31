Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA8C433E0
	for <io-uring@archiver.kernel.org>; Wed, 31 Mar 2021 01:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299C7619D3
	for <io-uring@archiver.kernel.org>; Wed, 31 Mar 2021 01:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhCaBcN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 30 Mar 2021 21:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhCaBb6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 30 Mar 2021 21:31:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CD9C061574;
        Tue, 30 Mar 2021 18:31:58 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRPi5-001DjA-TS; Wed, 31 Mar 2021 01:31:53 +0000
Date:   Wed, 31 Mar 2021 01:31:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 2/2] io_uring: add support for IORING_OP_MKDIRAT
Message-ID: <YGPRCeimsXXaoCGZ@zeniv-ca.linux.org.uk>
References: <20210330055957.3684579-1-dkadashev@gmail.com>
 <20210330055957.3684579-3-dkadashev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330055957.3684579-3-dkadashev@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Tue, Mar 30, 2021 at 12:59:57PM +0700, Dmitry Kadashev wrote:
> IORING_OP_MKDIRAT behaves like mkdirat(2) and takes the same flags
> and arguments.

had the questions about interplay with audit been resolved?
