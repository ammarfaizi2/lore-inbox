Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312497AbSDEMUV>; Fri, 5 Apr 2002 07:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSDEMUL>; Fri, 5 Apr 2002 07:20:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312497AbSDEMT7>; Fri, 5 Apr 2002 07:19:59 -0500
Subject: Re: raid,apm,ide, powers down too fast & corrupts raid
To: kernel@Expansa.sns.it (Luigi Genoni)
Date: Fri, 5 Apr 2002 13:36:40 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), brian@worldcontrol.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204051118120.13866-100000@Expansa.sns.it> from "Luigi Genoni" at Apr 05, 2002 11:19:25 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tSxM-0008C4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If the box is IDE then current 2.4.19pre/2.4.19-ac trees actually send
> > flush commands to the IDE disks to be sure its cleared everything out. It
> > might be that.
> 
> Does that work well with disk cache?
> (incidentally, I do not have actually IDE disks out of production, so I
> cannot test)

Its actually asking the IDE disk to flush its cache yes
