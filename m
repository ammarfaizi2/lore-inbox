Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUJWSBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUJWSBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUJWSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:01:40 -0400
Received: from are.twiddle.net ([64.81.246.98]:29062 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261263AbUJWR6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:58:17 -0400
Date: Sat, 23 Oct 2004 10:58:11 -0700
From: Richard Henderson <rth@twiddle.net>
To: alex@local.promotion-ie.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.9 on alpha noritake
Message-ID: <20041023175811.GA23184@twiddle.net>
Mail-Followup-To: alex@local.promotion-ie.de, linux-kernel@vger.kernel.org
References: <1098476483.11296.37.camel@pro30.local.promotion-ie.de> <1098520279.14984.12.camel@pro30.local.promotion-ie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098520279.14984.12.camel@pro30.local.promotion-ie.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 10:31:19AM +0200, alex@local.promotion-ie.de wrote:
> drivers/built-in.o(.text+0xdbbc):include/asm/io.h:73: undefined
> reference to `__ioremap'
> make: *** [.tmp_vmlinux1] Error 1

Got it.

> pc is at __raw_readw+0x4c/0x60
> ra is at vgacon_startup+0x4ec/0x750

I'll have a look.  Why are you using fbcon anyway?


r~
