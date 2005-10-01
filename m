Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVJAIA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVJAIA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 04:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVJAIA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 04:00:29 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:52662 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750777AbVJAIA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 04:00:29 -0400
Date: Sat, 1 Oct 2005 01:00:27 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: "Artem B. Bityutskiy" <dedekind@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MTD] kmalloc + memzero -> kzalloc conversion
Message-ID: <20051001080027.GM25424@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051001050003.GD11137@plexity.net> <1128152797.3546.15.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128152797.3546.15.camel@sauron.oktetlabs.ru>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01 2005, at 11:46, Artem B. Bityutskiy was caught saying:
> On Fri, 2005-09-30 at 22:00 -0700, Deepak Saxena wrote:
> > We have the API, so use it.
> > 
> > Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
> > 
> Well, does it really hurt if one does kmalloc() + memset(zero) instead? Is it worth fixing this? Doubts.

I see it more as an API usage cleanup then a "fix" of any sort. 

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
