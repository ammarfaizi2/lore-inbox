Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUJSIUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUJSIUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUJSIUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:20:37 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61857
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268379AbUJSIU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:20:28 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041018145008.GA25707@elte.hu>
References: <20041011215909.GA20686@elte.hu>
	 <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
	 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu>  <20041018145008.GA25707@elte.hu>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098173546.12223.737.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 10:12:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 16:50, Ingo Molnar wrote:
> i have released the -U5 Real-Time Preemption patch:

All sleep_on variants trigger the irqs_disabled() check in schedule(). 
tglx


