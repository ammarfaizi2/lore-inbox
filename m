Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVFUMtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVFUMtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVFUMnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:43:16 -0400
Received: from [85.8.12.41] ([85.8.12.41]:8632 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261383AbVFUMmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:42:04 -0400
Message-ID: <42B80AF9.2060708@drzeus.cx>
Date: Tue, 21 Jun 2005 14:41:29 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
References: <42B7F740.6000807@drzeus.cx> <Pine.LNX.4.61.0506211413570.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0506211413570.3728@scrub.home>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>Just adding explicit all over the place is really the worst solution. 
>Check if you can adjust data types/function prototypes.
>Lots of the signed stuff was added as a warning fix for Solaris, I'd 
>rather drop that than adding casts all over the place. So you also may 
>want to check the file history, why certain constructs were added.
>  
>

Is there some easy way to check the file history? Downloading a couple
of old kernels just for one file is a bit of a hassle. And I don't run
bk so I can't access that repository (is it even still present after
Linus' move?).

I'll start looking at removing the signed chars.

Rgds
Pierre

