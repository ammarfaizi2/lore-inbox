Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265389AbTL2UaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTL2UaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:30:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:49863 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265389AbTL2UaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:30:12 -0500
Date: Mon, 29 Dec 2003 12:30:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Wim Van Sebroeck <wim@iguana.be>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches
In-Reply-To: <20031229212221.J30061@infomag.infomag.iguana.be>
Message-ID: <Pine.LNX.4.58.0312291226400.2113@home.osdl.org>
References: <20030906125136.A9266@infomag.infomag.iguana.be>
 <20031229205246.A32604@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291209150.2113@home.osdl.org>
 <20031229212221.J30061@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Wim Van Sebroeck wrote:
> 
> Hmmm, the result of postponing these one-liners until 2.6.0 was out...

Yeah, I know. It's one of the downsides of having anal revision control, 
and BK is more anal than most.

I do end up taking patches that have this syndrome if it looks like the 
pain of not taking the messy revision history is larger than the pain of 
just fixing it. Sometimes it's hard to avoid.

But most of the time the proper thing to do is to just not merge
unnecessarily - if something is pending for a while, Bk does the merge
correctly anyway, so you can just leave it pending and have me pull from
an old tree (after you have verified in your own tree that the pull will 
succeed and do the right thing).

That way it ends up being trivial to see where/when the changes happened.

		Linus
