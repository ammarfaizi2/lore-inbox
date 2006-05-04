Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWEDUCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWEDUCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWEDUCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:02:23 -0400
Received: from mail.gmx.de ([213.165.64.20]:26022 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750900AbWEDUCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:02:22 -0400
X-Authenticated: #4399952
Date: Thu, 4 May 2006 22:02:22 +0200
From: Florian Paul Schmidt <mista.tapas@gmx.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sched_clock() uses are broken
Message-ID: <20060504220222.53cc13f9@mango.fruits>
In-Reply-To: <20060502132953.GA30146@flint.arm.linux.org.uk>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 14:29:53 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> However, this is not the case.  On x86 with TSC, it returns a 54 bit
> number.  This means that when t1 < t0, time_passed_ns becomes a very
> large number which no longer represents the amount of time.

Hi,

is this specific to the sched_clock() or does the rdtsc on these systems
only use 54 bit?

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
