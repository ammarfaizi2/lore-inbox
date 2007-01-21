Return-Path: <linux-kernel-owner+w=401wt.eu-S1751356AbXAULYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXAULYL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 06:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAULYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 06:24:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34462 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbXAULYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 06:24:10 -0500
Date: Sun, 21 Jan 2007 11:23:47 +0000 (GMT)
From: Artem Bityutskiy <dedekind@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>,
       Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
       linux-mtd@lists.infradead.org, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/mtd/ubi/: possible cleanups
In-Reply-To: <20070119184048.GR9093@stusta.de>
Message-ID: <Pine.LNX.4.64.0701211122480.6215@pentafluge.infradead.org>
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070119184048.GR9093@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SRS-Rewrite: SMTP reverse-path rewritten from <dedekind@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-19 at 19:40 +0100, Adrian Bunk wrote:
This patch contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused variable:
>   - debug.c: alloc_prints
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
I've committed this.

BTW: Do you really need that many different
>      CONFIG_MTD_UBI_DEBUG_* options?
>
The idea is to be able to switch debugging messages on/off for different 
units separately. But the number of the option may indeed be reduced - i 
will try to do this.

Thanks!

-- 
Best regards,
Artem Bityutskiy
