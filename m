Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289500AbSAONq2>; Tue, 15 Jan 2002 08:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289507AbSAONqS>; Tue, 15 Jan 2002 08:46:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16400 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289500AbSAONqK>; Tue, 15 Jan 2002 08:46:10 -0500
Date: Tue, 15 Jan 2002 13:57:56 +0000
From: Alan Cox <alan@aunt-tillie.org>
To: Giacomo Catenazzi <cate@debian.org>
Cc: "T. A." <tkhoadfdsaf@hotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        esr@thyrsus.com
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020115135756.A19738@lightning.swansea.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@aunt-tillie.org>,
	Giacomo Catenazzi <cate@debian.org>,
	"T. A." <tkhoadfdsaf@hotmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	esr@thyrsus.com
In-Reply-To: <fa.fslncfv.r6o11i@ifi.uio.no> <fa.hqe5uev.c60cjs@ifi.uio.no> <3C4427F6.3010703@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C4427F6.3010703@debian.org>; from cate@debian.org on Tue, Jan 15, 2002 at 02:00:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 02:00:38PM +0100, Giacomo Catenazzi wrote:
> How many people try new kernel with the wrong CPU configuration?
> (and mornally user know the name of own CPU, with netcards this is
> more difficult).

All of us get the CPU wrong. By using modules however I don't have to guess
the PCI devices. My system already did that. I just need the configurator
to hit M a lot and to work out which root devices are for the initrd.

The code for that exists

> PCI, USB and ISAPNP detection works well.
> ISA is a further step.
> I will send Eric the new detections and database for new probes (for ISA
> and others) drivers. So I hope also the ISA thread will end.

I suspect ISA is a dead loss - but again build all the modules, the user
system already has the right ones to load configured.

Alan

