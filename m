Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271150AbTG1VQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271153AbTG1VQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:16:24 -0400
Received: from lidskialf.net ([62.3.233.115]:8667 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S271150AbTG1VQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:16:03 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Alexander Rau <al.rau@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2 -- linux-2.5.75-acpi-irqparams-final4.patch
Date: Mon, 28 Jul 2003 22:16:01 +0100
User-Agent: KMail/1.5.2
References: <200307272305.12412.adq_dvb@lidskialf.net> <3F254E5F.8040700@gmx.de> <3F258E53.3070204@gmx.de>
In-Reply-To: <3F258E53.3070204@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307282216.01742.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Sorry, there's still a kernel oops during bootup. I'll provide a kernel
> > trace when I'm back at home.
> >
> > Regards, Al
>
> I tried to dump the kernel messages onto my printer. Unfortunatly it
> doesn't print anything, only with acpi=off.
>
> This is somehow unconventional, but here's a link for a screenshot of
> the trace. Sorry, one screen is missing but the messages were too fast
> for my camera :) I can still recognize a lots of ......... on the
> missing screen.
>
> http://w3studi.informatik.uni-stuttgart.de/~rauar/IMG_1120.JPG

Thats obviously either a bug in the ACPI parser, or a bug in the AML code of 
your BIOS. Can you send a copy of your /proc/acpi/dsdt. 

Oh er, as you can't boot it with ACPI, use 
http://people.freebsd.org/~takawata/pacpidump.tar.gz to dump it in non-ACPI 
mode..

