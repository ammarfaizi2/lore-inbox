Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267114AbUBRW3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267148AbUBRW3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:29:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:36805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267114AbUBRW3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:29:20 -0500
Date: Wed, 18 Feb 2004 14:28:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tridge@samba.org
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402181427230.2686@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org>
 <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org>
 <c0uj52$3mg$1@terminus.zytor.com> <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
 <4032D893.9050508@zytor.com> <Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
 <16435.55700.600584.756009@samba.org> <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Linus Torvalds wrote:
> 
> That's not my problem. That is _your_ problem, and I don't care. I 
> disagree violently with the notion that we would push this down to a 
> filesystem level.
> 
> Sorry, but there are limits to how much we care about broken operating 
> systems.

Side note: this only matters for cold cache entries anyway, so I doubt 
you'll see any performance improvement on a file server from passing the 
brain damage down to the lower levels. 

And I bet the performance advantages of _not_ doing native case 
insensitivity are likely to dominate hugely.

		Linus
