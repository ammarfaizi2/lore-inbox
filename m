Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUAECZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 21:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUAECZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 21:25:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:37571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265847AbUAECZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 21:25:54 -0500
Date: Sun, 4 Jan 2004 18:25:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <3FF8BDBB.4060708@tmr.com>
Message-ID: <Pine.LNX.4.58.0401041824150.2162@home.osdl.org>
References: <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
 <3FF5E952.70308@tmr.com> <m365fsu48n.fsf@defiant.pm.waw.pl> <3FF7A910.40703@tmr.com>
 <Pine.LNX.4.58.0401041232440.2162@home.osdl.org> <3FF8BDBB.4060708@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Bill Davidsen wrote:
> 
> You pointed out that this generates good code, I pointed out that it 
> also avoids future errors and is not just a trick for broken compilers. 
> I take your point about generating good code, I'm sorry you can't see 
> that avoiding code duplication is good practice even without the benefit 
> of better code.

Don't be silly. Using non-standard C is _never_ good practice.

If 'd' is a complex expression, and you want to avoid duplicating it, just 
create another temporary variable. 

THAT is good practice. Not strange gcc-only special code that other 
compilers won't touch.

		Linus
