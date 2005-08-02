Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVHBDX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVHBDX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 23:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVHBDX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 23:23:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261384AbVHBDXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 23:23:52 -0400
Date: Mon, 1 Aug 2005 20:22:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: lkml@dodo.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Report: 2.6.13-rc4-mm1: only 8 errors for 752 randconfig builds
Message-Id: <20050801202246.00aab187.akpm@osdl.org>
In-Reply-To: <71mte1lpe4fvbdpas6pa2023qdephibv2d@4ax.com>
References: <71mte1lpe4fvbdpas6pa2023qdephibv2d@4ax.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady <lkml@dodo.com.au> wrote:
>
> Greetings,
> 
> Automating random config kernel build testing, for 2.6.13-rc4-mm1:
> 
> Done processing 752 random builds, from which:
> ###   8 .configs produced errors
> ###  11 .configs produced undefs
> ###  52 .configs produced warnings
> 
> Abbreviated errors (first 2 lines/error):

whee.

I fixed a couple locally:

> arch/i386/kernel/cpu/transmeta.c: In function `init_transmeta':
> arch/i386/kernel/cpu/transmeta.c:82: error: invalid lvalue in assignment
> ...
> ipc/shm.c:174: error: `shmem_set_policy' undeclared here (not in a function)
> ipc/shm.c:174: error: initializer element is not constant

