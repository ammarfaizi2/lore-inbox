Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVHRJ7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVHRJ7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVHRJ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:59:53 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62139
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932153AbVHRJ7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:59:52 -0400
Subject: Re: 2.6.13-rc6-rt3
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200508181057.30828.s0348365@sms.ed.ac.uk>
References: <20050816121843.GA24308@elte.hu>
	 <200508181057.30828.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 18 Aug 2005 12:00:14 +0200
Message-Id: <1124359214.23647.320.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair,

On Thu, 2005-08-18 at 10:57 +0100, Alistair John Strachan wrote:
> The problem I'm having is that when the kernel probes my IDE devices it slows 
> down, taking ages to complete the probe. Henceforth the kernel seems to work 
> at a slower speed doing just about anything (compiling, etc.), but 
> interactive performance is okay. It's a bizarre problem.
> 
> Of course, I assumed this was due to the latest timer changes, and so I 
> disabled CONFIG_HIGH_RES_TIMERS and went back to CONFIG_HPET_TIMER.
> This works perfectly.

Can you please send me your .config which shows the problem ?

tglx


