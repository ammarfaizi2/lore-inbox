Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281072AbRK3Wb2>; Fri, 30 Nov 2001 17:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRK3WbT>; Fri, 30 Nov 2001 17:31:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20741 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281072AbRK3WbD>; Fri, 30 Nov 2001 17:31:03 -0500
Subject: Re: Deadlock on kernels > 2.4.13-pre6
To: emmanuele.bassi@iol.it (Emmanuele Bassi)
Date: Fri, 30 Nov 2001 22:39:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011130221334.A15353@wolverine.lohacker.net> from "Emmanuele Bassi" at Nov 30, 2001 10:13:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169wJt-00052j-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> work properly... Unless some corrections, not reported into the
> changelogs, did eventually occur between 2.4.13-pre* series and 2.4.13.

Nope.

> Even if it shows up to be a VIA problem, what do I have to do, to get my
> system work properly with this chipset?

The reason I ask is VIA have had a history of weird ISA DMA hangs when doing
certain other operations. It could be some combination of these triggering
problems.

> 01:00.0 VGA compatible controller: nVidia Corporation Riva TnT [NV04] (rev 04) (prog-if 00 [VGA])

Are you seeing the hangs in X11, and which X setup (one with agp loaded ?)
Also does it print "Activiating ISA DMA workarounds" during the boot ?

Alan
