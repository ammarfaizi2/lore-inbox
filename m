Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755376AbWKMWTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbWKMWTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755379AbWKMWTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:19:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755376AbWKMWTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:19:31 -0500
Date: Mon, 13 Nov 2006 14:19:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061113141921.a5c59a61.akpm@osdl.org>
In-Reply-To: <200611131658.06036.m.kozlowski@tuxland.pl>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611131658.06036.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 16:58:05 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> 	I tried to compile 2.6.19-rc5-mm1 on x86_64 box and it failed.
> Looking at the Documentation/Changes the box tools are a bit old but
> the kernel should compile. This was 'allmodconfig' with CONFIG_KVM=n
> because binutils are too old for that. So either this is a bug or
> Documentation/Changes should be updated soon.
> 
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o(.init.text+0x31b7): In function `alternative_instructions':
> arch/i386/kernel/alternative.c:437: undefined reference to `__stop_parainstructions'
> arch/x86_64/kernel/built-in.o(.init.text+0x31be):arch/i386/kernel/alternative.c:437: undefined reference to `__start_parainstructions'
> make: *** [.tmp_vmlinux1] Error 1

Thanks.  Please send me the .config and I'll see if it's still happening.
