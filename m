Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTE1Wgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTE1WgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:36:03 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:4727 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261352AbTE1WgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:36:00 -0400
Date: Wed, 28 May 2003 15:46:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-Id: <20030528154651.177488f3.akpm@digeo.com>
In-Reply-To: <20030528221812.GC255@elf.ucw.cz>
References: <20030521152255.4aa32fba.akpm@digeo.com>
	<20030521152334.4b04c5c9.akpm@digeo.com>
	<20030526093717.GC642@zaurus.ucw.cz>
	<20030528144839.47efdc4f.akpm@digeo.com>
	<20030528215551.GB255@elf.ucw.cz>
	<20030528150610.3df70031.akpm@digeo.com>
	<20030528221812.GC255@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2003 22:49:16.0575 (UTC) FILETIME=[5E06FAF0:01C3256B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Yes, x86-64 and sparc64 were converted.

OK, I know who to bug about those.

> It is really #included, sorry
> about that, but I found no other solution. Patch looks like:

> +#define INCLUDES
> +#include "compat_ioctl.c"

hm, how does the preprocessor locate this file?  Does the build system set
up a symlink?

