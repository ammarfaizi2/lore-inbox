Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135875AbRDYPFS>; Wed, 25 Apr 2001 11:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135874AbRDYPFI>; Wed, 25 Apr 2001 11:05:08 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21379 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135873AbRDYPFB>;
	Wed, 25 Apr 2001 11:05:01 -0400
Message-ID: <3AE6E797.A31803BE@mandrakesoft.com>
Date: Wed, 25 Apr 2001 11:04:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: Marcus Meissner <Marcus.Meissner@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: trident , pci_enable_device moved
In-Reply-To: <20010425090438.A12672@caldera.de> <20010425130624.A3216@caldera.de> <20010425104949.A31649@mp3revolution.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon wrote:
> Just a warning; I was informed by Alan that doing this for video
> drivers was unnecessary, since video devices were already enabled
> during bootup.

To clarify:  the primary display device is enabled and initialized, and
its video BIOS executed, when during BIOS startup and before the Linux
kernel gets control.  All other display devices are not only not
initialized, but they are disabled as well.

Marcus is doing sound ATM so I doubt this matters to him...

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
