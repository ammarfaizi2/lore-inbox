Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312546AbSCYUPI>; Mon, 25 Mar 2002 15:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312543AbSCYUO7>; Mon, 25 Mar 2002 15:14:59 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:51396
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S312540AbSCYUOx>; Mon, 25 Mar 2002 15:14:53 -0500
Date: Mon, 25 Mar 2002 15:26:17 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
Message-ID: <20020325152617.A18605@animx.eu.org>
In-Reply-To: <Pine.LNX.3.96.1020325141655.4219A-100000@gatekeeper.tmr.com> <E16paZT-0001Qe-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   The way you say that makes me think that it does support at some other
> > level... hot swap controller? Doesn't match MY hardware. Hot swap
> 
> Controller level hotswap works mostly (think about pcmcia ide for example)

Just to throw this out there.  Is it possible to make the ide subsystem look
like a scsi controller ?  that way the scsi layer could insert/remove
devices.  say: ide0/1 = scsi0 (assuming no other scsi controllers) and hda =
scsi0 channel0 id0 lun0  and hdc = scsi0 channel1 id0 lun0 ...

Personally, if it's doable, i'd like it.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
