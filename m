Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265483AbRFVR43>; Fri, 22 Jun 2001 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265482AbRFVR4J>; Fri, 22 Jun 2001 13:56:09 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10252 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265486AbRFVRz7>; Fri, 22 Jun 2001 13:55:59 -0400
Subject: Re: For comment: draft BIOS use document for the kernel
To: randy.dunlap@intel.com (Dunlap, Randy)
Date: Fri, 22 Jun 2001 18:55:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), linux-kernel@vger.kernel.org
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE38E@orsmsx31.jf.intel.com> from "Dunlap, Randy" at Jun 22, 2001 10:44:34 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DV9S-0003rJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Didn't you disable DMI scan recently, in favor of userspace
> DMI tools?

No. We still scan it but we dont print the stuff out

> > should probably provide the $PIR table, even if it does not 
> > provide non ACPI versions of other services.
> 
> Sorry, legacy-free => ACPI, certainly not a $PIR table IMO.

Umm maybe that needs rewording. The point is that if you are building an
ACPI only setup then it will generally run Linux providing you also add in
the $PIR table, even though the ACPI OS's certainly won't use it

> Personally I'd like to explore adding support to Linux for
> the Simple Boot Flag spec.
> (http://www.microsoft.com/HWDEV/desinit/simp_bios.htm

See ac17. Actually its a bit buggy in ac17 but Dave Jones has been fixing it.
Feel free to assist (arch/i386/kernel/bootflag.c)


