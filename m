Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUBRWYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUBRWYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:24:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:2242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266258AbUBRWYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:24:05 -0500
Date: Wed, 18 Feb 2004 14:23:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tridge@samba.org
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <16435.55700.600584.756009@samba.org>
Message-ID: <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org>
 <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org>
 <c0uj52$3mg$1@terminus.zytor.com> <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
 <4032D893.9050508@zytor.com> <Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
 <16435.55700.600584.756009@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004 tridge@samba.org wrote:
> 
> The second basic fact that I think is relevant is that its not
> possible to do case-insensitive filesystem operations efficiently
> without the filesystem having knowledge of the fact that you want a
> case-insensitive lookup.

That's not my problem. That is _your_ problem, and I don't care. I 
disagree violently with the notion that we would push this down to a 
filesystem level.

Sorry, but there are limits to how much we care about broken operating 
systems.

		Linus
