Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbREMSqL>; Sun, 13 May 2001 14:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263262AbREMSpw>; Sun, 13 May 2001 14:45:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54450 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263105AbREMSpq>;
	Sun, 13 May 2001 14:45:46 -0400
Message-ID: <3AFED656.92362303@mandrakesoft.com>
Date: Sun, 13 May 2001 14:45:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        "Manuel A. McLure" <mmt@unify.com>,
        "Rasmus =?iso-8859-1?Q?B=F8g?= Hansen" <moffe@amagerkollegiet.dk>,
        ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>,
        Dunlap Randy <randy.dunlap@intel.com>,
        Martin Diehl <mdiehlcs@compuserve.de>,
        Adrian Cox <adrian@humboldt.co.uk>, Capricelli Thomas <orzel@kde.org>,
        Ian Bicking <ianb@colorstudy.com>, John R Lenton <john@grulic.org.ar>
Subject: Re: PATCH 2.4.5.1: Fix Via interrupt routing issues
In-Reply-To: <E14z0l8-0006oS-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > +/* we will likely need a better ifdef, something like
> > + * ifdef CONFIG_EXTERNAL_APIC
> > + */
> > +#ifdef CONFIG_X86_IO_APIC
> 
> I disagree. The IO-APIC is the chipset APIC. It is distinct from the APIC
> on the processors.

Disagree with which part?  The fix, or likely needing a better ifdef?

>From the point of view of the Via southbridge chip, IO-APIC is
external...  The comment above the ifdef was more along the lines of,
"Via on PPC (OpenPIC?) might need this too, not just io-apic"

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
