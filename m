Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVECJOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVECJOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 05:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVECJOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 05:14:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7083 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261431AbVECJOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 05:14:36 -0400
Date: Tue, 3 May 2005 11:10:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig
 files (first part)
In-Reply-To: <20050503003400.GO3592@stusta.de>
Message-ID: <Pine.LNX.4.61.0505031107120.996@scrub.home>
References: <20050503003400.GO3592@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 May 2005, Adrian Bunk wrote:

> This patch is the majority of a patch by Jesper Juhl.
> 
> This patch renames all instances of "---help---" to simply "help" in all 
> of the Kconfig files.
> 
> The main reason for this patch (quoting Jesper) is:
> 
> Consistency. out of ~4000 help entries in 134 Kconfig files, 747 of 
> those entries use "---help---" as the keyword, the rest use just "help". 
> So the users of "---help---" are clearly a minority and by renaming them 
> we make things consistent. - I hate inconsistency. :-)

This has nothing to do with consistency but with readability.
This was introduced to better separate the help in large menu entries. In 
order to accept this patch, I would either like hear reasons, why this 
isn't needed anymore or I'd like to see an alternative, more consistent 
separator.

bye, Roman
