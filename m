Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbUECIrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUECIrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 04:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUECIrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 04:47:39 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:35989 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263612AbUECIri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 04:47:38 -0400
Date: Mon, 3 May 2004 09:46:59 +0100
From: Dave Jones <davej@redhat.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with spinlocks in SMP kernel
Message-ID: <20040503084658.GA29878@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Srinivas G." <srinivasg@esntechnologies.co.in>,
	linux-kernel@vger.kernel.org
References: <1118873EE1755348B4812EA29C55A9721D703E@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A9721D703E@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 12:57:12PM +0530, Srinivas G. wrote:

 > We developed a driver for PCI card. It was compiled and working fine under non-smp kernel. But when we port it into SMP kernel it is not working. System is going to hang permanently. What problem peter got at the following site, the same problem we got here. When we don't use spinlocks it is working fine under SMP kernel also. But when we use spinlocks it is not working under SMP kernel. The link peter posted the error I am sending here. 
 > http://www.linuxtv.org/mailinglists/linux-dvb/2002/06-2002/msg00178.html
 > I tried with spin_lock_irqsave(&xxx,flags) and spin_unlock_irqrestore(&xxx,flags). Then also system halts.
 > Why system is permanently hanging? What was the problem? Is their any OS problem?
 > We are using following configuration:
 > P4 HT Processor, RealTech 8139 Network card, Redhat 9.0 Kernel version 2.4.20-8smp.
 > Thanks in advance for any help you can come up with.

You forgot to include a pointer to the source for your driver.
Without which, no-one can help you.

		Dave

