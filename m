Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUBPXIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBPXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:05:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:30859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265939AbUBPXFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:05:15 -0500
Date: Mon, 16 Feb 2004 15:06:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net, rusty@rustcorp.com.au
Subject: Re: [PATCH][2.6-mm] split drain_local_pages
Message-Id: <20040216150654.38935399.akpm@osdl.org>
In-Reply-To: <20040216224425.GB6628@elf.ucw.cz>
References: <Pine.LNX.4.58.0402161720390.11793@montezuma.fsmlabs.com>
	<20040216224425.GB6628@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> The idea looks good to me, but there's something wrong with the patch:

Yes, it looks like Rusty fed me a load there.  Zwane's patch fixes it up
though.

There's no way of turning on the hotplug CPU code in 2.6.3-rc1-mm1, so I
assume we're awaiting the arch patches.

I made __drain_local_pages() static to page_alloc.c
