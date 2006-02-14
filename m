Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422819AbWBNVvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422819AbWBNVvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422820AbWBNVvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:51:21 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:44192
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1422819AbWBNVvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:51:20 -0500
Subject: Re: [patch] hrtimer: round up relative start time on low-res arches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060214122031.GA30983@elte.hu>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
	 <1139827927.4932.17.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602131208050.30994@scrub.home>
	 <20060214074151.GA29426@elte.hu>
	 <Pine.LNX.4.61.0602141113060.30994@scrub.home>
	 <20060214122031.GA30983@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 22:51:51 +0100
Message-Id: <1139953911.2480.532.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 13:20 +0100, Ingo Molnar wrote:
> CONFIG_TIME_LOW_RES is a temporary way for architectures to signal that 
> they simply return xtime in do_gettimeoffset(). In this corner-case we 
> want to round up by resolution when starting a relative timer, to avoid 
> short timeouts. This will go away with the GTOD framework.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


