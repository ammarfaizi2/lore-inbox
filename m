Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSHZSLs>; Mon, 26 Aug 2002 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHZSLs>; Mon, 26 Aug 2002 14:11:48 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58123
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318213AbSHZSLq>; Mon, 26 Aug 2002 14:11:46 -0400
Date: Mon, 26 Aug 2002 11:14:30 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Holger Grosenick <h.grosenick@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: System freeze on 2.4.18 / 19 SMP
In-Reply-To: <200208261436.44030.hgrosenick@web.de>
Message-ID: <Pine.LNX.4.10.10208261113070.24156-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2002, Holger Grosenick wrote:

> Hello
> 
> i have a reproducible system freeze using SuSE 8.0 with original kernel 2.4.19 
> (same with SuSE 2.4.18 kernel).
> 
> Hardware:
> 
> Asus P2B-Dual with 2x PIII 700 MHz (Bios 1013 - current)
> 896 MB RAM
> Promise PDC20267 off board IDE Controller (current bios release)
> aic7880 scsi-controller for CD-writers
> nvidia graphic card
> RTL-8139A based network card
> 
> /dev/hda: _NEC DV-5700B DVD-ROM on piix onboard controller, ide0
> /dev/hdc: IBM IC35L060AVVA07-0 on PDC20267 ide1
> /dev/hdd: IBM IC35L080AVVA07-0 on PDC20267 ide1
> /dev/hde: IBM IC35L060AVVA07-0 on PDC20267 ide2

OH MY!

The channels got decoupled!  This is very bad.

> /dev/hda: _NEC DV-5700B DVD-ROM on piix onboard controller, ide0

> /dev/hde: IBM IC35L060AVVA07-0 on PDC20267 ide1
> /dev/hdf: IBM IC35L080AVVA07-0 on PDC20267 ide1
> /dev/hdg: IBM IC35L060AVVA07-0 on PDC20267 ide2

That is what it should be.

Andre Hedrick
LAD Storage Consulting Group

