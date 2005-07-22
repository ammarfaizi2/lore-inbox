Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVGVG0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVGVG0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 02:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVGVG0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 02:26:40 -0400
Received: from mail.charite.de ([160.45.207.131]:36269 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262050AbVGVGZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 02:25:52 -0400
Date: Fri, 22 Jul 2005 08:25:48 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
Message-ID: <20050722062548.GJ25829@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050721180621.GA25829@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050721180621.GA25829@charite.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> The one message strinking me as odd during the boot-process is:
> Jul 21 19:50:01 kasbah kernel: AC'97 warm reset still in progress? [0xffffffff]

More details: If I unload the sounddriver:

# rmmod snd_intel8x0

and the reload it:

# modprobe snd_intel8x0

I get:

ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:06.0 to 64
AC'97 warm reset still in progress? [0xffffffff]
Intel ICH: probe of 0000:00:06.0 failed with error -5

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
