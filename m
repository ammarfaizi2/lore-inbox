Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWBMXfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWBMXfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWBMXfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:35:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030290AbWBMXfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:35:31 -0500
Date: Mon, 13 Feb 2006 15:34:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Cc: ananth@in.ibm.com, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com,
       hiramatu@sdl.hitachi.co.jp, systemtap@sources.redhat.com,
       jkenisto@us.ibm.com, linux-kernel@vger.kernel.org,
       sugita@sdl.hitachi.co.jp, soshima@redhat.com, haoki@redhat.com
Subject: Re: [PATCH][take 2] kretprobe: kretprobe-booster against 2.6.16-rc2
 for i386
Message-Id: <20060213153408.73266e4f.akpm@osdl.org>
In-Reply-To: <43F077C7.8060706@sdl.hitachi.co.jp>
References: <43DE0A53.3060801@sdl.hitachi.co.jp>
	<43DEC13E.8020200@sdl.hitachi.co.jp>
	<20060131145540.3e9a78be.akpm@osdl.org>
	<43E0B177.9020607@sdl.hitachi.co.jp>
	<43F077C7.8060706@sdl.hitachi.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp> wrote:
>
> Hi, Andrew
> 
> Here is a patch of kretprobe-booster for i386 against linux-2.6.16-rc2.

This patch is identical to what I have now in -mm.

> In the previous kretprobe-booster patch, I had a mistake about stack
> register. In this patch, the bug is fixed.
> 
> This bug was pointed by Chuck Ebbert, and there were two different
> patches(Chuck's and mine) to fix it. But both patches were dropped
> from -mm tree. So, I merged my patch into kretprobe-booster patch
> and attached it to this mail.

That was just me folding the fixup patches into the base patch.

I've updated the covering text in those email notifications.

