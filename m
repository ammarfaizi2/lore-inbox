Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267136AbSKSUOJ>; Tue, 19 Nov 2002 15:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbSKSUOJ>; Tue, 19 Nov 2002 15:14:09 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:19987 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267136AbSKSUOJ>; Tue, 19 Nov 2002 15:14:09 -0500
Date: Tue, 19 Nov 2002 15:21:08 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200211192021.gAJKL8A29487@devserv.devel.redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] Add back in <asm/system.h> and <linux/linkage.h> to <linux/interrupt.h>
In-Reply-To: <mailman.1037736361.32709.linux-kernel2news@redhat.com>
References: <mailman.1037736361.32709.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following trivial patch adds back <asm/system.h> and
><linux/kernel.h> to <linux/interrupt.h>.  Without it,
><linux/interrupt.h> is relying on <asm/system.h> to be implicitly
> included for smb_mb to be defined, and <linux/linkage.h> to be implicitly
> included for asmlinkage/FASTCALL/etc.

Right, RMK posted it a couple of days ago, without linkage.h though.

-- Pete
