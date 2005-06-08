Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVFHVIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVFHVIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVFHVIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:08:37 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:5506 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261633AbVFHVIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:08:36 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200506082108.j58L8Ac3022291@wildsau.enemy.org>
Subject: Re: [PATCH] struct thread_struct, asm-i386/processor.h: wrong datatype?
In-Reply-To: <20050606081626.GA15699@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Date: Wed, 8 Jun 2005 23:08:10 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> no. 'struct thread_struct' is the 'soft' thread-state structure. We 
> store data in the most convenient (and best performing) format - word 
> size in this case. The 'hard' data structure is 'struct tss_struct' - 
> where we of course define things in the way the CPU expects it.

I see. thanks for the answer.
