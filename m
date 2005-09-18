Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVIRHhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVIRHhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 03:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVIRHhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 03:37:11 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:56331 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751323AbVIRHhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 03:37:10 -0400
Date: Sun, 18 Sep 2005 09:38:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Move flags for preprocessing linker scripts to rule
Message-ID: <20050918073801.GC11257@mars.ravnborg.org>
References: <20050917144954.GA9800@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917144954.GA9800@wavehammer.waldi.eu.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastian.

> Move CPPFLAGS_vmlinux.lds settings into the .lds.S -> .lds rule. Any of
> the remaining CPPFLAGS definitions for .lds.S preprocessing sets this
> options.

I fail to see how arch specific settings are picked up.
See for example um that set CPPFLAGS_vmlinux in arch/um/Makefile.
There is no way this value is visible when buiding
arch/um/kernel/Makefile.

	Sam
