Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWHXGpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWHXGpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWHXGpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:45:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:24243 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030353AbWHXGpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:45:15 -0400
To: Edward Falk <efalk@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
References: <44ED157D.6050607@google.com>
From: Andi Kleen <ak@suse.de>
Date: 24 Aug 2006 08:45:11 +0200
In-Reply-To: <44ED157D.6050607@google.com>
Message-ID: <p7364gifx8o.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Falk <efalk@google.com> writes:

> Add spin_lock_string_flags and _raw_spin_lock_flags() to
> asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
> semantics on x86_64 as it does on i386 and does *not* have interrupts
> disabled while it is waiting for the lock.

Did it fix anything for you?

-Andi
