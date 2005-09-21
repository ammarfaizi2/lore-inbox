Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVIUHtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVIUHtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 03:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVIUHtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 03:49:15 -0400
Received: from [210.76.114.20] ([210.76.114.20]:15490 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1750731AbVIUHtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 03:49:14 -0400
Message-ID: <43311071.8070706@ccoss.com.cn>
Date: Wed, 21 Sep 2005 15:49:05 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: A pettiness question.
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All.
   
    I found there are use double operator ! continuously sometimes in 
kernel.
e.g:

    static inline int is_page_cache_freeable(struct page *page)
    {
        return page_count(page) - !!PagePrivate(page) == 2;
    }

    Who would like tell me why write like above?
   
  
    Thanks in advanced.


Liyu
