Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264671AbSJPBOa>; Tue, 15 Oct 2002 21:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264719AbSJPBOa>; Tue, 15 Oct 2002 21:14:30 -0400
Received: from zero.aec.at ([193.170.194.10]:30995 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S264671AbSJPBOa>;
	Tue, 15 Oct 2002 21:14:30 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Add extended attributes to ext2/3
References: <E181a3N-0006No-00@snap.thunk.org> <3DACAC0C.D4C497C1@digeo.com>
	<200210160211.39284.agruen@suse.de> <3DACB86A.829ECF3C@digeo.com>
From: Andi Kleen <ak@muc.de>
Date: 16 Oct 2002 03:20:08 +0200
In-Reply-To: <3DACB86A.829ECF3C@digeo.com>
Message-ID: <m3y98zp4c7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> The kernel has just gained supoprt for 64-bit sectors on ia32
> and PPC32 but the new mbcache code will not support that.

<nitpick> ... and x86-64 (CONFIG_X86 includes X86-64) 

But I wonder why this weird ifdef. Is there any reason why the other
architectures are not supported ? 

-Andi
