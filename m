Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVECNvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVECNvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVECNvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:51:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33196 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261532AbVECNvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:51:05 -0400
Date: Tue, 3 May 2005 15:47:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig
 files (first part)
In-Reply-To: <20050503105743.GE3592@stusta.de>
Message-ID: <Pine.LNX.4.61.0505031519310.996@scrub.home>
References: <20050503003400.GO3592@stusta.de> <Pine.LNX.4.61.0505031107120.996@scrub.home>
 <20050503092202.GC3592@stusta.de> <Pine.LNX.4.61.0505031202080.996@scrub.home>
 <20050503105743.GE3592@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 May 2005, Adrian Bunk wrote:

> > So why exactly has to be removed? Is it ugly? Does it make Kconfig worse?
> 
> The ugly thing is that there are currently two different ways to express 
> the same thing. It only causes confusion for people who think those 
> different syntaxes had a different meaning.

Languages often have more than one way to express something, this is not 
different.
Early on there was some confusion about this from people writing new 
Kconfig entries (not just reading existing ones), but this was became a 
non-issue since it's documented now.

> > Sorry, but only because it's not used that often, is not enough of a 
> > reason for me to remove it. If it helps only a little bit to spot the help 
> > text start easier, it's IMO worth to keep it.
> 
> Do you or does anyone else have a problem with spotting the help text 
> start with "only" two additional spaces indentation?

It is easier to spot! Is it a big help? I don't know, but I don't see any 
improvement in removing them.
Personally I'd rather leave it to the maintainers of these entries, if 
they don't like it, they can remove it. If this feature is one day not 
used anymore, I'll remove it.

> If it's only for Aunt Tillie it's not required.

Please stop this. There is no point in arguing whether this is good or bad 
for Aunt Tillie.

bye, Roman
