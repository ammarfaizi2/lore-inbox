Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292798AbSBZU3z>; Tue, 26 Feb 2002 15:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293225AbSBZU3p>; Tue, 26 Feb 2002 15:29:45 -0500
Received: from bitmover.com ([192.132.92.2]:13766 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292798AbSBZU3e>;
	Tue, 26 Feb 2002 15:29:34 -0500
Date: Tue, 26 Feb 2002 12:29:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
Message-ID: <20020226122933.C10806@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andreas Dilger <adilger@turbolabs.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226113402.K12832@lynx.adilger.int> <Pine.GSO.4.21.0202262117380.8085-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0202262117380.8085-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Feb 26, 2002 at 09:19:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So in case he wants a few csets only, I have to redo my for-Him-to-pull-tree.
> In which case I don't see any advantages compared to emailing a patch with
> changeset- and file-specific comments. Especially since setting up a
> for-Him-to-pull-tree requires setting up a publically accessible BK server.

You can set up a publically accessible tree here, if you need one, 
see the Hosting link on our website.  You can make your tree publically
accessible in multiple ways, with varying levels of security, see
"bk help bkd".

The advantage of allowing him to pull is that you won't have the same data
in your BK tree twice, which you would have if you sent him diffs and then
pulled the diffs from him.  This is ESPECIALLY IMPORTANT if you have renames
(and creates/deletes are a sort of rename) in your patch.

If the situation is that you've created a scratch tree, specifically for
sending stuff to Linus and you aren't going to use it for anything else
or build on it, then you can send him regular diffs, and toss the tree
once you know he accepted them.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
