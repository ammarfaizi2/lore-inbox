Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSCTBiz>; Tue, 19 Mar 2002 20:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSCTBif>; Tue, 19 Mar 2002 20:38:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40452 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311025AbSCTBib>; Tue, 19 Mar 2002 20:38:31 -0500
Subject: Re: Filesystem Corruption (ext2) on Tyan S2462, 2xAMD1900MP, 2.4.17SMP
To: andre@linux-ide.org (Andre Hedrick)
Date: Wed, 20 Mar 2002 01:53:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ken@irridia.com (Ken Brownfield),
        m.knoblauch@TeraPort.de,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.LNX.4.10.10203191726290.525-100000@master.linux-ide.org> from "Andre Hedrick" at Mar 19, 2002 05:29:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nVId-0000yr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am in their lab trying to reproduce the error and I have found some docs
> which could help address the error of the 4byte FIFO issue in the engine.
> It looks fixable on paper.

Andre - if you want the info I have from the previous stuff I was involved
in I can strip out customer company info and send it on.

> As for the AMD driver, who knows which version is in that kernel.

2.4.18 has a very old one
2.4.18-ac has the Andre/AMD updated one, but not the further updates.
		(eg it turns off SWDMA on more chipsets than it needs to)

Alan
