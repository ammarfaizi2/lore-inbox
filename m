Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269205AbUJKTvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269205AbUJKTvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbUJKTvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:51:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:25748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269205AbUJKTvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:51:16 -0400
Date: Mon, 11 Oct 2004 12:55:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
Message-Id: <20041011125507.3d733256.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com>
References: <20041011032502.299dc88d.akpm@osdl.org>
	<Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> How about the following?
> 
> remove-lock_section-from-x86_64-spin_lock-asm.patch
>   remove LOCK_SECTION from x86_64 spin_lock asm

OK.

> allow-x86_64-to-reenable-interrupts-on-contention.patch
>   Allow x86_64 to reenable interrupts on contention

IIRC Andi made skeptical noises about this one.
