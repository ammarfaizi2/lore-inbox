Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTE1Vhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 17:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbTE1Vhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 17:37:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:64365 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261169AbTE1Vhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 17:37:48 -0400
Date: Wed, 28 May 2003 14:48:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-Id: <20030528144839.47efdc4f.akpm@digeo.com>
In-Reply-To: <20030526093717.GC642@zaurus.ucw.cz>
References: <20030521152255.4aa32fba.akpm@digeo.com>
	<20030521152334.4b04c5c9.akpm@digeo.com>
	<20030526093717.GC642@zaurus.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 21:51:04.0166 (UTC) FILETIME=[3C63A860:01C32563]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> I guess "ioctl32 emulation should be shared
> accross architectures" should go on the
> list...

Noted, thanks.

> (and I have patches but Linus ignores
> them... would it be okay to merge them
> through you?)

This is a bit like "arch/foo/kernel/irq.c should be common code".  The
patch exists, but is late, intrusive and only a cleanup.

However I think experience teaches us that we should push ahead with
changes like this because not doing it creates more aggregate pain than
doing it.

So yes, please send me your latest and we'll try to get it underway.

