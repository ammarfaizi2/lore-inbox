Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUDWXAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUDWXAj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUDWXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:00:38 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:18195 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261661AbUDWXA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:00:27 -0400
Date: Sat, 24 Apr 2004 00:00:23 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Alex Stewart <alex@foogod.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] neofb patches
In-Reply-To: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
Message-ID: <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, I've got everything except the blanking patch (which isn't finished
> anyway) converted to apply cleanly to James' patched driver source. 
> Everything works fine on my laptop as far as I can tell.  Additional
> feedback is welcome.
> 
> I've put up a web page for the patches.  They can be found at
> http://www.foogod.com/~alex/neofb/

Got it. I merged your patches. I also did a few fixes. The code had issues 
with non byte align images, i.e sparc 12x22 fonts. Now it works. I posted 
at

http://phoenix.infradead.org:~/jsimmons/neofb.diff.gz

This is against the latest kernel.



