Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269164AbUJKQZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269164AbUJKQZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUJKPuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:50:24 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:43653 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S269065AbUJKPrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:47:47 -0400
Date: Mon, 11 Oct 2004 18:47:45 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com>
References: <20041011032502.299dc88d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, Andrew Morton wrote:

> - I wasn't going to do any -mm's until after 2.6.9 comes out.  But we need
>   this one so that people who have patches in -mm can check that I haven't
>   failed to push anything critical.  If there's a patch in here which you
>   think should be in 2.6.9, please let me know.

How about the following?

remove-lock_section-from-x86_64-spin_lock-asm.patch
  remove LOCK_SECTION from x86_64 spin_lock asm

allow-x86_64-to-reenable-interrupts-on-contention.patch
  Allow x86_64 to reenable interrupts on contention

The former is a fix.

Thanks,
	Zwane
