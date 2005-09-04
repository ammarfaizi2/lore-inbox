Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVIDRRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVIDRRh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVIDRRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:17:37 -0400
Received: from mail.charite.de ([160.45.207.131]:58511 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932071AbVIDRRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:17:36 -0400
Date: Sun, 4 Sep 2005 19:17:31 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
Message-ID: <20050904171731.GU20898@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050721180621.GA25829@charite.de> <20050722062548.GJ25829@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722062548.GJ25829@charite.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> * Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> 
> > The one message strinking me as odd during the boot-process is:
> > Jul 21 19:50:01 kasbah kernel: AC'97 warm reset still in progress? [0xffffffff]
> 
> More details: If I unload the sounddriver:
> 
> # rmmod snd_intel8x0
> 
> and the reload it:
> 
> # modprobe snd_intel8x0
> 
> I get:
> 
> ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> AC'97 warm reset still in progress? [0xffffffff]
> Intel ICH: probe of 0000:00:06.0 failed with error -5

Fixed with 2.6.3-git3
