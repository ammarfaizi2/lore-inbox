Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRHMRSE>; Mon, 13 Aug 2001 13:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270319AbRHMRRz>; Mon, 13 Aug 2001 13:17:55 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:2058 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S270314AbRHMRRp>; Mon, 13 Aug 2001 13:17:45 -0400
Message-ID: <3B780BAC.3D0C724C@loewe-komp.de>
Date: Mon, 13 Aug 2001 19:17:32 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Kompetenzzentrum Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.4-64GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: add Tvia cyberpro 5050 to sound/trident.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have hacked up the drivers/sound/trident.c to also
support the TVia/IGST CyberPro5050 audio (&video) controller.

This chip is common in settop boxes. I don't know if you can
buy any PCI cards "off the shelf".
I think there is still interest in support for this 
"old" chip (3 years old), at least in the "embedded market".

Does it make sense to include it in trident.c?

BTW, the listed maintainer ollie@sis.com.tw does not work any 
more on this driver.
