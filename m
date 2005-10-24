Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbVJXRsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbVJXRsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVJXRsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:48:16 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:63674 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751193AbVJXRsP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:48:15 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon, 24 Oct 2005 19:47:49 +0200
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] rocketport: make it work when statically linked into kernel
Cc: linux-kernel@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
       support@comtrol.com, Andrew Morton <akpm@osdl.org>
In-reply-to: <200510241059.54259.bjorn.helgaas@hp.com>
Message-Id: <20051024174748.5B92822AEEF@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The driver had incorrectly wrapped module_init(rp_init) in #ifdef MODULE,
>so it worked only when compiled as a module.
>
[snip]
>
>I also added the Comtrol support email address to MAINTAINERS.
Nope, the e-mail in fact doesn't exist, I (or somebody?) removed it from
MAINTAINERS.
[They'll send you, that you can use web interface as an automatic answer.]

[snip]
>Index: denk/MAINTAINERS
>===================================================================
>--- denk.orig/MAINTAINERS	2005-10-24 10:49:03.000000000 -0600
>+++ denk/MAINTAINERS	2005-10-24 10:49:04.000000000 -0600
>@@ -2041,6 +2041,7 @@
> 
> ROCKETPORT DRIVER
> P:	Comtrol Corp.
>+M:	support@comtrol.com
> W:	http://www.comtrol.com
> S:	Maintained

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
