Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVHHHUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVHHHUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 03:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVHHHUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 03:20:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:34275 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750745AbVHHHUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 03:20:10 -0400
Date: Mon, 8 Aug 2005 09:20:06 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Xin Zhao <uszhaoxin@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Any access control mechanism that allow exceptions?
In-Reply-To: <4ae3c1405080600082ef440c8@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508080918500.18088@yvahk01.tjqt.qr>
References: <4ae3c1405080600082ef440c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>I want to lock down a directory to be read-only, say, /etc, for system
>security. Unfortunately, some valid system tools might need to
>create/modified files like "/etc/dhclient-eth0.conf".  To avoid
>disrupting the normal running of those tools, I might have to allow
>certain files to be created under /etc.

read-only-by-root is not enough?

*mumble* unionfs could help you in part.



Jan Engelhardt
-- 
