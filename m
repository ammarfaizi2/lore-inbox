Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272715AbTG1Hkd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272716AbTG1Hkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:40:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:20658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272715AbTG1Hka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:40:30 -0400
Date: Mon, 28 Jul 2003 00:55:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-Id: <20030728005543.0dca9531.akpm@osdl.org>
In-Reply-To: <20030728075106.GA660@gmx.de>
References: <200307280112.16043.kernel@kolivas.org>
	<20030728075106.GA660@gmx.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor Wodecki <wodecki@gmx.de> wrote:
>
> The same problem I wrote you
>  yesterday about O9, when starting OpenOffice and bzip2'ing in the
>  background OO becomes nearly unusable

There's a known problem with OpenOffice and its use of sched_yield(). 
sched_yield() got changed in 2.6 and it makes OO unusable when there is
other stuff happening.

Apparently it has been fixed in recent OpenOffice versions.  If you cannot
reproduce this problem in any other application I'd be saying it is "not a
bug".

