Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291097AbSBLPAi>; Tue, 12 Feb 2002 10:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291102AbSBLPA2>; Tue, 12 Feb 2002 10:00:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16140 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291097AbSBLPAU>; Tue, 12 Feb 2002 10:00:20 -0500
Subject: Re: 2.4.18-pre9-xfs-shawn4  -  hpfs bug
To: pozsy@sch.bme.hu (Pozsar Balazs)
Date: Tue, 12 Feb 2002 15:13:16 +0000 (GMT)
Cc: spstarr@sh0n.net (Shawn Starr), dag@bakke.com (Dag Bakke),
        linux-kernel@vger.kernel.org (Linux), linux-xfs@oss.sgi.com (xfs)
In-Reply-To: <Pine.GSO.4.30.0202121516400.15721-100000@balu> from "Pozsar Balazs" at Feb 12, 2002 03:17:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aecO-00025H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also get an oops with 2.4.18-pre9-ac1, pnpbios compiled in, but no xfs.
> So I think this is a pnpbios problem.

At the moment there are a couple of pnpbios related problems that need
fixing. One of them is -ac kernel triggered due to the way the pnpbios
docking thread is created, the other is the inability of some bios vendors
to read documentation and may be harder to cure

For the moment assume its the docking thread. I'll fix that soonish
