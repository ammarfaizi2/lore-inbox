Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVGUJ6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVGUJ6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVGUJ6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:58:16 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:45585 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S261734AbVGUJ6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:58:15 -0400
Message-ID: <42DF71B3.5030705@rainbow-software.org>
Date: Thu, 21 Jul 2005 11:58:11 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <lnx4us@gmail.com>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete files in 2.6 tree
References: <42DED9F3.4040300@gmail.com> <42DF6F34.4080804@gmail.com>
In-Reply-To: <42DF6F34.4080804@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> drivers/scsi/NCR5380.c
> drivers/scsi/NCR5380.h

These files are used by many older SCSI drivers:

rainbow@pentium:/usr/src/linux/drivers/scsi$ grep -l NCR5380\[.\]\[ch\] *
Kconfig
NCR5380.c
NCR5380.h
atari_scsi.c
dmx3191d.c
dtc.c
g_NCR5380.c
g_NCR5380.h
g_NCR5380.ko
g_NCR5380.o
g_NCR5380_mmio.c
mac_scsi.c
mac_scsi.h
pas16.c
sun3_NCR5380.c
sun3_scsi.c
sun3_scsi.h
sun3_scsi_vme.c
t128.c
t128.h

-- 
Ondrej Zary
