Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSDDTSF>; Thu, 4 Apr 2002 14:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSDDTRt>; Thu, 4 Apr 2002 14:17:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293596AbSDDTRi>; Thu, 4 Apr 2002 14:17:38 -0500
Subject: Re: raid,apm,ide, powers down too fast & corrupts raid
To: brian@worldcontrol.com
Date: Thu, 4 Apr 2002 20:34:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020404183410.GA2904@top.worldcontrol.com> from "brian@worldcontrol.com" at Apr 04, 2002 10:34:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tD02-0006bw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm running Linux 2.4.18 on this system.  Has this problem been
> addressed in any later versions?

If the box is IDE then current 2.4.19pre/2.4.19-ac trees actually send
flush commands to the IDE disks to be sure its cleared everything out. It
might be that.
