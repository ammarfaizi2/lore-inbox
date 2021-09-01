Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE51C432BE
	for <io-uring@archiver.kernel.org>; Wed,  1 Sep 2021 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA7B61075
	for <io-uring@archiver.kernel.org>; Wed,  1 Sep 2021 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbhIASFd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 1 Sep 2021 14:05:33 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34355 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239445AbhIASFd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 1 Sep 2021 14:05:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Umx5lkm_1630519474;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0Umx5lkm_1630519474)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 02:04:35 +0800
Subject: Re: [PATCH liburing v2] tests: test early-submit link fails
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <3e02f382b64e7d09c8226ee02be130e4b75d890e.1630424932.git.asml.silence@gmail.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <d6b0f034-3c69-d769-fc4c-59145ec741da@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 02:04:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3e02f382b64e7d09c8226ee02be130e4b75d890e.1630424932.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

在 2021/8/31 下午11:49, Pavel Begunkov 写道:
> Add a whole bunch of tests for when linked requests fail early during
> submission.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: correct io_uring_submit() ret checks with !drain
> 
Thanks for this test.
