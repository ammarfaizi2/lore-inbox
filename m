Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUKOOr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUKOOr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbUKOOr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:47:28 -0500
Received: from zamok.crans.org ([138.231.136.6]:23251 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261612AbUKOOpx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:45:53 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.10-rc1-mm5: fixes more warnings wrt kunmap_atomic API changes
References: <87is87w538.fsf@barad-dur.crans.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Mon, 15 Nov 2004 15:45:58 +0100
In-Reply-To: <87is87w538.fsf@barad-dur.crans.org> (Mathieu Segaud's message of
	"Mon, 15 Nov 2004 15:37:47 +0100")
Message-ID: <87brdzw4pl.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud <matt@minas-morgul.org> disait dernièrement que :

> Hi Andrew,
> (sorry for resending, forgot to CC: linux-kernel@)
>
> This fixes more compile warnings, wrt last changes in k[un]map* prototypes.
> I did _not_ fold the compile fix you provided later when CONFIG_HIGHMEM=y,
> in include/asm-i386/highmem.h.

hum sorry, the compile fix in include/asm-i386/highmem.h is included...

> This patch:
>   - adds (char *) casts in pte_* macros in include/asm-i386/pgtable.h
>     when CONFIG_HIGHMEM=y
>   - casts swp_entry_t object entry to (char *) in mm/shmem.c.

-- 
"scanf is tough" --- programmer Barbie...

	- Alexander Viro on linux-kernel

