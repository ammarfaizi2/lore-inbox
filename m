Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129986AbRCAWUW>; Thu, 1 Mar 2001 17:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbRCAWUC>; Thu, 1 Mar 2001 17:20:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15632 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129986AbRCAWT7>; Thu, 1 Mar 2001 17:19:59 -0500
Subject: Re: APM suspend system lockup under 2.4.2 and 2.4.2ac1
To: chief@bandits.org (John Fremlin)
Date: Thu, 1 Mar 2001 22:22:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bradley_kernel@yahoo.com (bradley mclain),
        linux-kernel@vger.kernel.org
In-Reply-To: <m21yshtg28.fsf@boreas.yi.org.> from "John Fremlin" at Mar 01, 2001 08:00:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YbSv-0000FY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why not use kernel/pm.c:pm_register? Then you can either refuse
> suspend or have a proper workaround.

Feel free to provide code. I suspect you can do something like
refuse to suspend if the device is open at all and reload the firmware, reinit
it on resume if it was idle.

I dont have the hardware

