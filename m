Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVGWUE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVGWUE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 16:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVGWUEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 16:04:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10515 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261561AbVGWUEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 16:04:24 -0400
Date: Sat, 23 Jul 2005 22:04:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz, mulix@mulix.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Alan Cox <alan@redhat.com>
Subject: Device supported by the OSS trident driver not supported by ALSA
Message-ID: <20050723200417.GI3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm currently creating a list of OSS drivers where all the hardware 
supported by them is also supported by ALSA. The goal is to schedule 
them for removal (except someone tells that for one or more of them ALSA 
support is inferior).


The OSS trident driver has 5 different pci_device_id entries.

For 4 of them there seems to be similar ALSA support, but I can't find 
any ALSA equivalent for the following entry:
        {PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5050,
         PCI_ANY_ID, PCI_ANY_ID, 0, 0, CYBER5050},

Can anyone tell my why this device is supported by the OSS trident 
driver but not by ALSA?


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

