Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275096AbTHGDxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 23:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275097AbTHGDxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 23:53:55 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:3500 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S275096AbTHGDxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 23:53:54 -0400
Message-ID: <3F31D1C0.1000601@genebrew.com>
Date: Thu, 07 Aug 2003 00:12:48 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rahul Karnik <rahul@genebrew.com>
CC: Valdis.Kletnieks@vt.edu, Jeff Sipek <jeffpc@optonline.net>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
References: <200308061830.05586.jeffpc@optonline.net> <3F319EE7.8010409@techsource.com>            <200308062126.37658.jeffpc@optonline.net> <200308070312.h773Ce6h004590@turing-police.cc.vt.edu> <3F31CED7.2070207@genebrew.com>
In-Reply-To: <3F31CED7.2070207@genebrew.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Karnik wrote:

> Actually (correct me if I am wrong, but doesn't:
> 
> for(int i = 0; i < TIMEOUT > 0; i++)
> 
> translate to:
> 
> for(int i = 1; i < TIMEOUT; i++)
> 
> rather than:
> 
> for(int i = 0; i < TIMEOUT; i++)?

Never mind. I was smoking something.

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

