Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVCANtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVCANtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCANtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:49:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52383 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261905AbVCANtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:49:22 -0500
Date: Mon, 21 Feb 2005 00:14:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: WareKala <warekala@lag.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sysfs, PCI-devices and power management
Message-ID: <20050220231420.GA1444@openzaurus.ucw.cz>
References: <1108819774.11821.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108819774.11821.12.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I don't know if this is the "right place(TM)" to ask about this, and if
> it isn't, I apologize. But the fact is that I haven't found any help
> from anywhere else and I can't learn enough without asking. So, the
> situation is like this: I am using a laptop and want to minimize the
> power consumption by shutting down unneeded components. Under windozer a
> program called Battery Doubler does the same by for example shutting
> down not-needed PCI devices. I too, tried to shut down certain devices
> by doing "echo 3 > /sys/devices/pci*/*0a*/power/state", but that didn't
> work. state was still a zero. So, I then 
This is called runtime power managment; it still needs to be implemented.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

