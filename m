Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbTA0WH7>; Mon, 27 Jan 2003 17:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267309AbTA0WH7>; Mon, 27 Jan 2003 17:07:59 -0500
Received: from smtp.terra.es ([213.4.129.129]:60134 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id <S267311AbTA0WHz>;
	Mon, 27 Jan 2003 17:07:55 -0500
Date: Mon, 27 Jan 2003 23:16:27 +0100
From: Arador <diegocg@teleline.es>
To: Bill Davidsen <davidsen@tmr.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm5: cpu1 not working
Message-Id: <20030127231627.2b23e456.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.3.96.1030127162924.27928C-101000@gatekeeper.tmr.com>
References: <20030124224836.639ebefa.diegocg@teleline.es>
	<Pine.LNX.3.96.1030127162924.27928C-101000@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003 16:34:22 -0500 (EST)
Bill Davidsen <davidsen@tmr.com> wrote:

> That's the thing I would expect to see if you used 'noapic' and watchdog. 
> I posted over the weekend that I have been seeing some inobvious results
> to IPC benchmarking with scombinations of noapic and watchdog, but I
> didn't snap the interrupts. I'll be happy to add that to my list of stuff
> to try next weekend, but the box is not a toy during the week, and I would
> have a five hour round trip drive if a reboot failed, so I'll pass on
> trying it until I'll in the same room. 

no "noapic" here:

kernel /boot/linux-2.5.59-mm5 root=/dev/hda5 ro vga=0x30a profile=2 nmi_watchdog=1
