Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFHONh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFHONh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFHONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:13:37 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23963
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261202AbVFHONc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:13:32 -0400
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323235@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323235@MAILIT.keba.co.at>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 08 Jun 2005 16:14:20 +0200
Message-Id: <1118240060.20785.630.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 16:02 +0200, kus Kusche Klaus wrote:
> > i have released the -V0.7.48-00 Real-Time Preemption patch, 
> [snip]
> > be affected that much (besides possible build issues). Non-x86 arches
> > wont build. Some regressions might happen, so take care..
> 
> What arches are likely to work in the near future?
> I've seen that "Kconfig.RT" is sourced for i386, x86_64, ppc, 
> and mips, but not for arm.
> 
> arm is one of the platforms we are interested in, any chances?

We have a working version for ARM based on a primary patch which
integrates ARM into the generic irq handling

tglx



