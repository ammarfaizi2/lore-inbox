Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422916AbWJRUbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422916AbWJRUbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422923AbWJRUbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:31:40 -0400
Received: from www.osadl.org ([213.239.205.134]:31121 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422916AbWJRUbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:31:39 -0400
Subject: Re: +
	dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie-remove-incorrect-warning-in-kernel-timerc.patch
	added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: cotte@de.ibm.com, mingo@elte.hu, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610182026.k9IKQIl0016830@shell0.pdx.osdl.net>
References: <200610182026.k9IKQIl0016830@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 22:32:19 +0200
Message-Id: <1161203540.5274.232.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 13:26 -0700, akpm@osdl.org wrote:
> Problem is, that the warning assumes that there are always pending timer
> events on a system when a CPU is going idle.  But this is not true in
> general, the system may be waiting for an I/O interruption, or the CPU may
> wait for an interprocessor signal.  The patch below removes the warning,
> please apply.

Makes sense.

Acked-by: Thomas Gleixner <tglx@linutronix.de>



