Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263068AbUK0ACD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbUK0ACD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbUK0ABZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:01:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263068AbUKZTl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:41:26 -0500
Subject: Re: [2.6 patch] sstfb.c: make some code static
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ghozlane Toumi <gtoumi@laposte.net>, Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20041121153646.GA2829@stusta.de>
References: <20041121153646.GA2829@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101336587.2571.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 24 Nov 2004 22:49:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-21 at 15:36, Adrian Bunk wrote:
> The patch below makes some needlessly global code static.

No it doesn't. It makes some functions static (which is fine) and adds
some nasty messy pointless #ifdefs. It touches no variable at all.

Please check your description texts and also don't fill the kernel with
ifdef crap. Probably the __setup stuff should be a module param new
style too.

