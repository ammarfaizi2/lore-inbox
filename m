Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWE3K1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWE3K1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWE3K1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:27:08 -0400
Received: from www.osadl.org ([213.239.205.134]:33731 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932234AbWE3K1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:27:06 -0400
Subject: Re: RT_PREEMPT problem with cascaded irqchip
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Yann.LEPROVOST@wavecom.fr
Cc: Sven-Thorsten Dietrich <sven@mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>
In-Reply-To: <OF5C056C3F.1146A6FD-ONC125717E.0035221D-C125717E.00377E2F@wavecom.fr>
References: <OF5C056C3F.1146A6FD-ONC125717E.0035221D-C125717E.00377E2F@wavecom.fr>
Content-Type: text/plain
Date: Tue, 30 May 2006 12:27:49 +0200
Message-Id: <1148984870.20582.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 12:00 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Hi folks,
> 
> However, when calling desc->chip->mask, the function at91rm9200_mask_irq is
> called instead of gpio_mask_irq !

Well, propably the chip setting of the gpio interrupts is not correct.
Can you show me the code please ?

	tglx


