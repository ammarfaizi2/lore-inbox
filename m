Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVANVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVANVGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVANVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:03:45 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:11827 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262106AbVANUy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:54:29 -0500
Date: Fri, 14 Jan 2005 21:55:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 2/8 ] ltt for 2.6.10 : core headers
Message-ID: <20050114205507.GD8385@mars.ravnborg.org>
Mail-Followup-To: Karim Yaghmour <karim@opersys.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <41E76279.5020507@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E76279.5020507@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karim.

> +++ linux-2.6.10-relayfs-ltt/include/linux/ltt-core.h	2005-01-13 22:21:56.000000000 -0500
> @@ -0,0 +1,430 @@
> +/*
> + * linux/include/linux/ltt-core.h
> + *
> + * Copyright (C) 1999-2004 Karim Yaghmour (karim@opersys.com)
> + *
> + * This contains the core definitions for the Linux Trace Toolkit.
> + */
include/linux/*.h is supposed to include only definitions used by other
parts of the kernel.
Definitions used only internally by ltt shall stay in kernel/

This is generally agreed upon, but not yet common practice.

Btw. did you run it through sparse?
Not that I found something, but did not see sparse annotation at first
sight.

	Sam
