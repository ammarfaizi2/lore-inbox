Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293026AbSCJMx0>; Sun, 10 Mar 2002 07:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293028AbSCJMxQ>; Sun, 10 Mar 2002 07:53:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23566 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293026AbSCJMxJ>; Sun, 10 Mar 2002 07:53:09 -0500
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 10 Mar 2002 13:08:25 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), gone@us.ibm.com (Patricia Gaughen),
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <m1zo1gzx60.fsf@frodo.biederman.org> from "Eric W. Biederman" at Mar 10, 2002 12:42:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16k33p-0006Ra-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I will tenatively vote in favor of this kind of action.  There
> are a couple of directions to consider.  This is a two dimensional
> problem.

That should not be suprising 

> Dimension 1.  Different basic hardware architectures. 
>   (pc,numaq,visws,voyager)
(and others upcoming)

> Dimension 2.  Different firmware implementations.  
>   (pcbios,linuxbios,openfirmware,acpi?)

i386-pc-pcbios

Maybe autoconf got the concept right. You don't neccessarily want to think
of it as a grid though. A lot of the stuff is i386-*-pcbios and i386-pc-*

Alan


