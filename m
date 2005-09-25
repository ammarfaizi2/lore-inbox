Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVIYVB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVIYVB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 17:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVIYVB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 17:01:27 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:13727
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932290AbVIYVB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 17:01:26 -0400
Subject: Re: [ANNOUNCE] ktimers subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christopher Friesen <cfriesen@nortel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, george@mvista.com,
       johnstul@us.ibm.com, paulmck@us.ibm.com
In-Reply-To: <Pine.LNX.4.61.0509250052390.3728@scrub.home>
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509201247190.3743@scrub.home>
	 <1127342485.24044.600.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509221816030.3728@scrub.home> <43333EBA.5030506@nortel.com>
	 <Pine.LNX.4.61.0509230151080.3743@scrub.home>
	 <1127458197.24044.726.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509240443440.3728@scrub.home>
	 <20050924051643.GB29052@elte.hu>
	 <Pine.LNX.4.61.0509241212170.3728@scrub.home>
	 <1127570212.15115.77.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509250052390.3728@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 25 Sep 2005 23:02:02 +0200
Message-Id: <1127682122.15115.97.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-25 at 01:45 +0200, Roman Zippel wrote:

> The multiply is not necessarly cheap, if the arch has no 32x32->64 
> instruction, gcc will generate a call to __muldi3().

Can you please point out which architectures do not have a 32x32->64
instruction ?

tglx


