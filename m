Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVDAJf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVDAJf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVDAJf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:35:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:62689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262678AbVDAJfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:35:17 -0500
Date: Fri, 1 Apr 2005 01:34:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove all kernel bugs
Message-Id: <20050401013454.1205a3f5.akpm@osdl.org>
In-Reply-To: <20050401090744.GD15453@waste.org>
References: <20050401090744.GD15453@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> I've been sitting on this patch for a while, figured it's high time I
>  shared it with the world. This patch eliminates all kernel bugs, trims
>  about 35k off the typical kernel, and makes the system slightly
>  faster. The patch is against the latest bk snapshot, please apply.

ho-hum, more ifdefs.

How's about you nuke PAGE_BUG first?  Just replace it with BUG() everywhere.

Or do it as a later patch - doesn't matter much I guess.

Or tell me to naff off and don't do it at all ;)
