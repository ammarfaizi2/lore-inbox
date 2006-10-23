Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWJWOyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWJWOyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWJWOyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:54:38 -0400
Received: from www.osadl.org ([213.239.205.134]:27618 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964901AbWJWOyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:54:37 -0400
Subject: Re: [2.6.19-rc1   APIC BUG?] kernel 2.6.19-rc1 or later can not
	generate ISA irq properly on DUAL-CPU system.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061022162948.1cf26ad6.komurojun-mbn@nifty.com>
References: <20061022162948.1cf26ad6.komurojun-mbn@nifty.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 16:55:39 +0200
Message-Id: <1161615339.22373.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-22 at 16:29 +0900, Komuro wrote:
> Hello,
> 
> kernel 2.6.19-rc1 or later can not generate ISA irq properly on DUAL-CPU system.
> kernel 2.6.18 work properly.
> 
> I think this problem is caused by IRQ-subsystem change on 2.6.19-rc1.

I have to wait until tomorrow until I get access to a system with ISA
network card.

> Please advise.

Does the box boot into login ? If yes, can you please provide the output
of /proc/interrupts ?

	tglx


