Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131012AbRCJLeg>; Sat, 10 Mar 2001 06:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131015AbRCJLeQ>; Sat, 10 Mar 2001 06:34:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59911 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131012AbRCJLeH>; Sat, 10 Mar 2001 06:34:07 -0500
Subject: Re: [PATCH]: allow notsc option for buggy cpus
To: dhd@eradicator.org (David Huggins-Daines)
Date: Sat, 10 Mar 2001 11:36:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <877l1yxtlg.fsf@monolith.eradicator.org> from "David Huggins-Daines" at Mar 09, 2001 09:09:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bhfX-0006hg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 600E's CPU doesn't actually use SpeedStep (it's only a 400MHz
> Mobile Pentium2, SpeedStep made its debut with the 600MHz Mobile
> Pentium3), but rather some kind of external speed throttling... which
> accomplishes basically the same thing, and makes one wonder why Intel
> had to go and trademark the idea of incorporating it into the CPU.

Its external on the 'speedstep' mostly. Take a look at what little docs
there are and you can see the mobile PIII chipset does it

> I think this behaviour can be controlled with tpctl for the Thinkpads
> and possibly with the Toshiba utils on Toshibas...

If tpctl can do it and we know how it does it then that may be sufficient since
the kernel init code can use DMI to find the 600E, tpctl copied code to go
to high speed, bogomip it and then drop back.

