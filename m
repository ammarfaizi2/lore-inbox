Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVGVNS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVGVNS2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 09:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVGVNS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 09:18:27 -0400
Received: from mail.charite.de ([160.45.207.131]:17610 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261266AbVGVNS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 09:18:27 -0400
Date: Fri, 22 Jul 2005 15:18:25 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
Message-ID: <20050722131825.GR8528@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050721180621.GA25829@charite.de> <20050722062548.GJ25829@charite.de> <200507221614.28096.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200507221614.28096.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Denis Vlasenko <vda@ilport.com.ua>:

> Not happening here on 2.6.12:

2.6.12 didn't have kexec (unless it's a -mm kernel)
So how could you boot using kexec then?

> Dunno what to do next. Shots in the dark:
> 
> Did it wok with 2.6.12 for you?
> 
> Maybe start adding printks in snd_intel8x0_create(),
> where snd_intel8x0_chip_init() is eventually called.
> You want to find out what is the difference in hw behaviour
> bebween good and bad boot.
> 
> Maybe do a superfluous pci_disable_device/pci_enable_device pair there.

I can try that.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
