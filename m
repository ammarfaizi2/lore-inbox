Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288596AbSADLJS>; Fri, 4 Jan 2002 06:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288599AbSADLJI>; Fri, 4 Jan 2002 06:09:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63759 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288597AbSADLJD>; Fri, 4 Jan 2002 06:09:03 -0500
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 4 Jan 2002 11:20:00 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        pogosyan@phys.ualberta.ca (Dmitri Pogosyan),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020104112834.A20724@suse.cz> from "Vojtech Pavlik" at Jan 04, 2002 11:28:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MSOG-0003ch-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > RH 2.4.2-x. That was before we had the official VIA solution to the chipset
> > bug. It was better to be safe than sorry for an end user distro.
> 
> But ... did this (limiting UDMA to 2) stop the bug from being manifested?

Mostly yes. The VIA bug appears to be dependant on heavy PCI loading. Now
we have a proper fix its all ok.

If you want a list of what VIA changes are in which RH release kernels
arjanv@redhat.com  can you give you a precise summary.
