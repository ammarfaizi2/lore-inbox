Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8DC432BE
	for <io-uring@archiver.kernel.org>; Fri, 27 Aug 2021 17:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0F460FE6
	for <io-uring@archiver.kernel.org>; Fri, 27 Aug 2021 17:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhH0RFq (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:05:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:35153 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232844AbhH0RFq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 27 Aug 2021 13:05:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UmI3UiN_1630083895;
Received: from 192.168.31.215(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UmI3UiN_1630083895)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 28 Aug 2021 01:04:55 +0800
Subject: Re: [PATCH for-5.15 v3 0/2] fix failed linkchain code logic
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210827094609.36052-1-haoxu@linux.alibaba.com>
 <40dee78d-1283-1067-cc7b-94b493eb2150@kernel.dk>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <180ec124-79b1-2274-4570-9b0d6620d512@linux.alibaba.com>
Date:   Sat, 28 Aug 2021 01:04:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <40dee78d-1283-1067-cc7b-94b493eb2150@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

在 2021/8/27 下午9:27, Jens Axboe 写道:
> On 8/27/21 3:46 AM, Hao Xu wrote:
>> the first patch is code clean.
>> the second is the main one, which refactors linkchain failure path to
>> fix a problem, detail in the commit message.
> 
> Thanks for pulling this one to completion - applied!
> 
sorry for the delay.
