Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290536AbSBFODo>; Wed, 6 Feb 2002 09:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290550AbSBFODX>; Wed, 6 Feb 2002 09:03:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290536AbSBFODT>; Wed, 6 Feb 2002 09:03:19 -0500
Subject: Re: How to check the kernel compile options ?
To: cr@sap.com (Christoph Rohland)
Date: Wed, 6 Feb 2002 14:16:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), Andries.Brouwer@cwi.nl, hpa@zytor.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <m3ofj2galz.fsf@linux.local> from "Christoph Rohland" at Feb 06, 2002 11:36:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YSs7-0005GY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you are going to cat it onto the end of the kernel image just
> > mark it __initdata and shove a known symbol name on it. It'll get
> > dumped out of memory and you can find it trivially by using tools on
> > the binary
> 
> What about putting such info into a (swappable) tmpfs file with
> shmem_file_setup?

That is indeed an extremely cunning plan. Paticularly as /proc/config can
be a symlink to it
