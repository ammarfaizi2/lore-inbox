Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290297AbSBKUKy>; Mon, 11 Feb 2002 15:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290309AbSBKUKo>; Mon, 11 Feb 2002 15:10:44 -0500
Received: from zero.tech9.net ([209.61.188.187]:30227 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290297AbSBKUKc>;
	Mon, 11 Feb 2002 15:10:32 -0500
Subject: Re: [PATCH] 2.5.4 PREEMPT on UP x86 breakage
From: Robert Love <rml@tech9.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, roy@karlsbakk.net, torvalds@transmeta.com
In-Reply-To: <200202111744.SAA08449@harpo.it.uu.se>
In-Reply-To: <200202111744.SAA08449@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 15:10:33 -0500
Message-Id: <1013458234.805.442.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 12:44, Mikael Pettersson wrote:
> In 2.5.4, CONFIG_PREEMPT breaks UP x86 kernels by triggering
> the BUG in release_kernel_lock(), kernel/sched.c, line 664.
> The patch below fixed it for me. It's a bit crude, but smp.h
> doesn't export the #define if CONFIG_SMP is disabled.

This is indeed a proper change.  Thank you,

	Robert Love

