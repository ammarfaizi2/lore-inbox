Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288028AbSABXpg>; Wed, 2 Jan 2002 18:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288033AbSABXm2>; Wed, 2 Jan 2002 18:42:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58127 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288029AbSABXmI>; Wed, 2 Jan 2002 18:42:08 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Wed, 2 Jan 2002 23:52:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102180926.B21788@thyrsus.com> from "Eric S. Raymond" at Jan 02, 2002 06:09:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LvBq-00064O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > priviledged. /sbin/dmidecode executes slightly priviledged code which will
> > core dump not crash the box if it misparses the mapped table.
> 
> You're thinking inside-out again.  Sigh...user privileges. *User* privileges! 

Its simple. If the sysadmin has decided the user can see the DMI data (which
is itself an open question since if you have the serial number you can often
use that alone to do really *irritating* things to university/workplace IT
people you don't like [1].

Alan
[1] like getting vendors to turn up and take it away because its "faulty"
