Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbVHXFie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbVHXFie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 01:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVHXFie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 01:38:34 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:52360 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751473AbVHXFid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 01:38:33 -0400
Message-ID: <430C07F0.8010001@temple.edu>
Date: Wed, 24 Aug 2005 01:38:56 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [-mm PATCH] drivers/char/speakup/synthlist.h - Fix warnings with
 -Wundef
References: <430B8063.8070301@temple.edu> <20050824053703.GA23807@mipter.zuzino.mipt.ru>
In-Reply-To: <20050824053703.GA23807@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> 
>>-#define  CFG_TEST(name) (name)
>>+#define  CFG_TEST(name) defined(name)
> 
> 
> No. Just remove this obfuscating macro.

Agreed, here is the fixed patch

Signed-Off-By: Nick Sillik <n.sillik@temple.edu>

