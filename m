Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVDBVwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDBVwo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVDBVtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:49:05 -0500
Received: from fire.osdl.org ([65.172.181.4]:57259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261290AbVDBVl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:41:29 -0500
Date: Sat, 2 Apr 2005 13:41:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: fix u32 vs. pm_message_t in drivers/mmc,mtd,scsi
Message-Id: <20050402134110.24ece2e2.akpm@osdl.org>
In-Reply-To: <20050402212954.GA2152@elf.ucw.cz>
References: <20050402212954.GA2152@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
>  This is last of the series. I tried to submit patches through their
>  mainainers (when they were easy to determine, our MAINTAINERS file
>  sucks).

You mean that there are patches in addition to these seven?

>  Unfortunately that probably means some patches will fail to
>  propagate and I'll have to fix up after -rc2 or something. Hopefully
>  diff will be fairly small by that time.

This sort of thing is a pain all round whichever way we do it.  Right now
the various subsystem trees are about as small as they ever get, so the
time is good to push all this in.

You should go through the whole -mm, check to see whether there is work
pending in bk-*.patch which also needs conversion.

