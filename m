Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTI2J1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTI2J1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:27:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34975 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262940AbTI2J1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:27:33 -0400
Date: Mon, 29 Sep 2003 11:23:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Boszormenyi Zoltan <zboszor@externet.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
In-Reply-To: <3F77F752.7020404@externet.hu>
Message-ID: <Pine.LNX.4.56.0309291120001.30209@localhost.localdomain>
References: <3F77F752.7020404@externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003, Boszormenyi Zoltan wrote:

> this is a version against -test6-mm1.
> Three differences from -test6-G3:
> - Makefile EXTRAVERSION
> - include/asm-i386/mmu.h trivial reject fix
> - fs/proc/array.c, {task|current}->[e]uid replaced
>    with tsk_[e]uid({task|current}) to compile.
> 
> The system is RH9, all errata fixes applied.
> X does not start up. After
> echo "0|1" >/proc/sys/kernel/exec-shield
> it starts.

hm, X needed at least one fix along the way. (it assumed malloc()  
executability on x86.) XFree86-4.3.0-33 works fine on my box, which
version are you using?

	Ingo
