Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266140AbRF2SAq>; Fri, 29 Jun 2001 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266146AbRF2SAg>; Fri, 29 Jun 2001 14:00:36 -0400
Received: from [194.213.32.142] ([194.213.32.142]:9988 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266135AbRF2R7Z>;
	Fri, 29 Jun 2001 13:59:25 -0400
Message-ID: <20010629005419.H525@bug.ucw.cz>
Date: Fri, 29 Jun 2001 00:54:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Matthias Urlichs <smurf@noris.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        D.A.Fedorov@inp.nsk.su
Cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <E15D4VG-0001Lw-00@the-village.bc.nu> <p05100305b757ae11c10d@[10.2.6.42]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <p05100305b757ae11c10d@[10.2.6.42]>; from Matthias Urlichs on Thu, Jun 21, 2001 at 04:03:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >No. The IRQ might be shared, and you get a slight problem if you just disabled
> >an IRQ needed to make progress for user space to handle the IRQ
> 
> Two choices:
> 
> - Disallow shared interrupts for usermode drivers.

That's hard... If you your notebook comes with soundcard and ltmodem
sharing the irq, and ltmodem only has userspace driver, you are
screwed.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
