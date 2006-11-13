Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933168AbWKMXhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbWKMXhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933169AbWKMXhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:37:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933168AbWKMXhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:37:54 -0500
Date: Mon, 13 Nov 2006 15:37:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061113153746.49a31e1b.akpm@osdl.org>
In-Reply-To: <200611132326.36002.m.kozlowski@tuxland.pl>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611131658.06036.m.kozlowski@tuxland.pl>
	<20061113141921.a5c59a61.akpm@osdl.org>
	<200611132326.36002.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 23:26:35 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> > >   LD      .tmp_vmlinux1
> > > arch/x86_64/kernel/built-in.o(.init.text+0x31b7): In function
> > > `alternative_instructions': arch/i386/kernel/alternative.c:437: undefined
> > > reference to `__stop_parainstructions'
> > > arch/x86_64/kernel/built-in.o(.init.text+0x31be):arch/i386/kernel/alterna
> > >tive.c:437: undefined reference to `__start_parainstructions' make: ***
> > > [.tmp_vmlinux1] Error 1
> >
> > Thanks.  Please send me the .config and I'll see if it's still happening.
> 
> Please find .config attached.

Thanks.  The paravirt patches have churned a bit recently and we appear to
have fixed this one.

