Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263262AbREMSuv>; Sun, 13 May 2001 14:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263263AbREMSul>; Sun, 13 May 2001 14:50:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40199 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263262AbREMSue>; Sun, 13 May 2001 14:50:34 -0400
Subject: Re: PATCH 2.4.5.1: Fix Via interrupt routing issues
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 13 May 2001 19:47:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        arjanv@redhat.com, Axel.Thimm@physik.fu-berlin.de (Axel Thimm),
        mmt@unify.com (Manuel A. McLure),
        moffe@amagerkollegiet.dk (Rasmus =?iso-8859-1?Q?B=F8g?= Hansen),
        std7652@et.FH-Osnabrueck.DE (ARND BERGMANN),
        randy.dunlap@intel.com (Dunlap Randy),
        mdiehlcs@compuserve.de (Martin Diehl),
        adrian@humboldt.co.uk (Adrian Cox), orzel@kde.org (Capricelli Thomas),
        ianb@colorstudy.com (Ian Bicking), john@grulic.org.ar (John R Lenton)
In-Reply-To: <3AFED656.92362303@mandrakesoft.com> from "Jeff Garzik" at May 13, 2001 02:45:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z0tg-0006pU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I disagree. The IO-APIC is the chipset APIC. It is distinct from the APIC
> > on the processors.
> 
> Disagree with which part?  The fix, or likely needing a better ifdef?

Needing a better ifdef

> >From the point of view of the Via southbridge chip, IO-APIC is
> external...  The comment above the ifdef was more along the lines of,
> "Via on PPC (OpenPIC?) might need this too, not just io-apic"

That will be an architecture specific quirk. I don't actually think you can
better. Somehow I always assumed ppc people had better taste in bridges 8)
