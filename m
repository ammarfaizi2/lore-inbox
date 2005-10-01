Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVJAIFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVJAIFE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 04:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVJAIFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 04:05:04 -0400
Received: from [195.209.228.254] ([195.209.228.254]:49289 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1750778AbVJAIFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 04:05:03 -0400
Message-ID: <433E432B.7010406@yandex.ru>
Date: Sat, 01 Oct 2005 12:04:59 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: dsaxena@plexity.net
Cc: "Artem B. Bityutskiy" <dedekind@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MTD] kmalloc + memzero -> kzalloc conversion
References: <20051001050003.GD11137@plexity.net> <1128152797.3546.15.camel@sauron.oktetlabs.ru> <20051001080027.GM25424@plexity.net>
In-Reply-To: <20051001080027.GM25424@plexity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> I see it more as an API usage cleanup then a "fix" of any sort. 
> 
Well, actually it may be helpful in only future, for example, if it is 
known that the allocated memory is zero-filled already, memzero() may be 
avoided at all.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
