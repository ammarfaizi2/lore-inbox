Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbREMSmV>; Sun, 13 May 2001 14:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbREMSmM>; Sun, 13 May 2001 14:42:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29959 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262324AbREMSmD>; Sun, 13 May 2001 14:42:03 -0400
Subject: Re: PATCH 2.4.5.1: Fix Via interrupt routing issues
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 13 May 2001 19:38:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        arjanv@redhat.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        Axel.Thimm@physik.fu-berlin.de (Axel Thimm),
        mmt@unify.com (Manuel A. McLure),
        moffe@amagerkollegiet.dk ( Rasmus =?iso-8859-1?Q?B=F8g?= Hansen),
        std7652@et.FH-Osnabrueck.DE (ARND BERGMANN),
        randy.dunlap@intel.com (Dunlap Randy),
        mdiehlcs@compuserve.de (Martin Diehl),
        adrian@humboldt.co.uk (Adrian Cox), orzel@kde.org (Capricelli Thomas),
        ianb@colorstudy.com (Ian Bicking), john@grulic.org.ar (John R Lenton)
In-Reply-To: <3AFEC426.50B00B78@mandrakesoft.com> from "Jeff Garzik" at May 13, 2001 01:28:06 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z0l8-0006oS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* we will likely need a better ifdef, something like 
> + * ifdef CONFIG_EXTERNAL_APIC
> + */
> +#ifdef CONFIG_X86_IO_APIC 

I disagree. The IO-APIC is the chipset APIC. It is distinct from the APIC
on the processors.
