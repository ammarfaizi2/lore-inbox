Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161160AbWJPXGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161160AbWJPXGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWJPXGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:06:09 -0400
Received: from xenotime.net ([66.160.160.81]:29060 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161160AbWJPXGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:06:06 -0400
Date: Mon, 16 Oct 2006 16:07:38 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, Matt LaPlante <kernel1@cyberdogtech.com>,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix typos in doc and comments (1)
Message-Id: <20061016160738.2199bbcb.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0610170040510.30479@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610170040510.30479@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 00:50:56 +0200 (MEST) Jan Engelhardt wrote:

> 
> 
> Changes persistant -> persistent. www.dictionary.com does not know 
> persistant (with an A), but should it be one of those things you can 
> spell in more than one correct way, let me know.

I agree with it, but IIRC Alan said it could be either way.

> Index: linux-2.6.19-rc2/lib/textsearch.c
> ===================================================================
> --- linux-2.6.19-rc2.orig/lib/textsearch.c
> +++ linux-2.6.19-rc2/lib/textsearch.c
> @@ -40,7 +40,7 @@
>   *       configuration according to the specified parameters.
>   *   (3) User starts the search(es) by calling _find() or _next() to
>   *       fetch subsequent occurrences. A state variable is provided
> - *       to the algorihtm to store persistant variables.
> + *       to the algorihtm to store persistent variables.

fix /algorithm/ while here?
or did Matt already fix that one?

>   *   (4) Core eventually resets the search offset and forwards the find()
>   *       request to the algorithm.
>   *   (5) Algorithm calls get_next_block() provided by the user continously

---
~Randy
