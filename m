Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135652AbREBQxD>; Wed, 2 May 2001 12:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135646AbREBQwn>; Wed, 2 May 2001 12:52:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57616 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135404AbREBQwY>; Wed, 2 May 2001 12:52:24 -0400
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
To: jdike@karaya.com (Jeff Dike)
Date: Wed, 2 May 2001 17:55:16 +0100 (BST)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org
In-Reply-To: <200105021754.MAA02910@ccure.karaya.com> from "Jeff Dike" at May 02, 2001 12:54:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uzuI-0003wC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Everything is there. SCSI and ISDN have the equivalent devices of the
> > "lo" driver for the networking layer. Or the equivalent of tun/tap
> > devices for the ethernet layer.
> 
> Is this sufficient to do driver development?  TUN/TAP doesn't let me write 
> ethernet drivers inside UML.

For ISDN not really. For SCSI yes - scsi generic would let you write a virtual
scsi adapter 'owning' some physical devices

