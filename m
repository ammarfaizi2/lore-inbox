Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbSKSXIe>; Tue, 19 Nov 2002 18:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbSKSXIe>; Tue, 19 Nov 2002 18:08:34 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:12768 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S267550AbSKSXIe>; Tue, 19 Nov 2002 18:08:34 -0500
Date: Tue, 19 Nov 2002 16:15:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][TRIVIAL] Add back in <asm/system.h> and <linux/linkage.h> to <linux/interrupt.h>
Message-ID: <20021119231535.GG779@opus.bloom.county>
References: <mailman.1037736361.32709.linux-kernel2news@redhat.com> <200211192021.gAJKL8A29487@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211192021.gAJKL8A29487@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:21:08PM -0500, Pete Zaitcev wrote:
> > The following trivial patch adds back <asm/system.h> and
> ><linux/kernel.h> to <linux/interrupt.h>.  Without it,
> ><linux/interrupt.h> is relying on <asm/system.h> to be implicitly
> > included for smb_mb to be defined, and <linux/linkage.h> to be implicitly
> > included for asmlinkage/FASTCALL/etc.
> 
> Right, RMK posted it a couple of days ago, without linkage.h though.

Then RMK's isn't complete as it needs both. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
