Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVJAHqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVJAHqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVJAHqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:46:40 -0400
Received: from [195.209.228.254] ([195.209.228.254]:45961 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1750773AbVJAHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:46:39 -0400
Subject: Re: [PATCH] [MTD] kmalloc + memzero -> kzalloc conversion
From: "Artem B. Bityutskiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: dsaxena@plexity.net
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051001050003.GD11137@plexity.net>
References: <20051001050003.GD11137@plexity.net>
Content-Type: text/plain
Organization: MTD
Date: Sat, 01 Oct 2005 11:46:37 +0400
Message-Id: <1128152797.3546.15.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 22:00 -0700, Deepak Saxena wrote:
> We have the API, so use it.
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> 
Well, does it really hurt if one does kmalloc() + memset(zero) instead? Is it worth fixing this? Doubts.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

