Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVBIL2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVBIL2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 06:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVBIL2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 06:28:16 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29087
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261806AbVBIL2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 06:28:14 -0500
Subject: Re: Preempt Real-time for ARM
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Sven Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
In-Reply-To: <1107628604.5065.54.camel@dhcp153.mvista.com>
References: <1107628604.5065.54.camel@dhcp153.mvista.com>
Content-Type: text/plain
Date: Wed, 09 Feb 2005 12:28:11 +0100
Message-Id: <1107948492.17747.31.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-05 at 10:36 -0800, Daniel Walker wrote:

> The biggest point of discussion relates to the interrupts in threads
> implementation. It is largely identical to what is implemented in the
> generic irq handling. However, ARM doesn't not implement generic irq
> handling, and will not support it in the near future. I am not in
> support of two different threaded interrupt implementations. 

We have done the conversion to the generic irq handling and it works
fine on a couple of machines. 

I'm just waiting until the new SMP bits are there before I have another
go and clean up the missing SMP bits.

tglx


