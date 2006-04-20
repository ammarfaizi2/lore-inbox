Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWDTCSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWDTCSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 22:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDTCSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 22:18:39 -0400
Received: from mx19.sac.fedex.com ([199.81.217.126]:46059 "EHLO
	mx19.sac.fedex.com") by vger.kernel.org with ESMTP id S1750721AbWDTCSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 22:18:39 -0400
Date: Thu, 20 Apr 2006 10:18:38 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Arkadiusz Miskiewicz <arekm@maven.pl>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <200604191752.18797.arekm@maven.pl>
Message-ID: <Pine.LNX.4.64.0604201013120.6204@boston.corp.fedex.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <200604191752.18797.arekm@maven.pl>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/20/2006
 10:18:32 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 04/20/2006
 10:18:34 AM,
	Serialize complete at 04/20/2006 10:18:34 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2006, Arkadiusz Miskiewicz wrote:
> It contains AHCI, right? Then try
> http://www.spinnaker.de/linux/c1320/sata-resume-2.6.16.5.patch

Yes, the IBM X60s is using AHCI.

libata version 1.20 loaded.
ahci 0000:00:1f.2: version 1.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA 
mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part


> It seems that nothing happened in this area in last 2 months. It no 
> longer applies (parts of it are already in mailine, other parts changed 
> too much). Z60* ThinkPads probably need that patch.

You're right. I tried to patch it with 2.6.17-rc2 and it doesn't seem to 
merge well. Oh well, guess have to wait for a while ...


Thanks for the pointer.

Jeff.
