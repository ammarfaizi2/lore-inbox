Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78925C07E97
	for <io-uring@archiver.kernel.org>; Sat,  3 Jul 2021 10:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B6861623
	for <io-uring@archiver.kernel.org>; Sat,  3 Jul 2021 10:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGCKuE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 3 Jul 2021 06:50:04 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34483 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhGCKuD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 3 Jul 2021 06:50:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UeYGk8G_1625309248;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UeYGk8G_1625309248)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 03 Jul 2021 18:47:28 +0800
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Subject: Question about sendfile
Message-ID: <6a7ceb04-3503-7300-8089-86c106a95e96@linux.alibaba.com>
Date:   Sat, 3 Jul 2021 18:47:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi Pavel,
I found this mail about sendfile in the maillist, may I ask why it's not
good to have one pipe each for a io-wq thread.
https://lore.kernel.org/io-uring/94dbbb15-4751-d03c-01fd-d25a0fe98e25@gmail.com/

Thanks,
Hao
