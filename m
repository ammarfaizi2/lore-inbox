Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVAZH0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVAZH0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 02:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVAZH0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 02:26:32 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:34970
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262372AbVAZH03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 02:26:29 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3f250c71050125161175234ef9@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <20050111083837.GE26799@dualathlon.random>
	 <3f250c71050121132713a145e3@mail.gmail.com>
	 <3f250c7105012113455e986ca8@mail.gmail.com>
	 <20050122033219.GG11112@dualathlon.random>
	 <3f250c7105012513136ae2587e@mail.gmail.com>
	 <1106689179.4538.22.camel@tglx.tec.linutronix.de>
	 <3f250c71050125161175234ef9@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 08:26:27 +0100
Message-Id: <1106724387.4538.36.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 20:11 -0400, Mauricio Lin wrote:
> > Can you please show the kernel messages ?
> 
> OK. We will try to reach a situation that the printk messages can be
> written entirely in the log file and show you the kernel messages. But
> as I said: usually the printks messages are not written in the log
> file using Andrea's patch. But using the original OOM Killer we can
> see the messages in the log file. The syslog.conf file is the same for
> both OOM Killer(Andrea and Original). Do you have any idea what is
> happening to log file?

Add "console=ttyS0,115200" to your commandline so you get all the
messages on the serial console.

tglx


