Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbRENQRT>; Mon, 14 May 2001 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262245AbRENQRJ>; Mon, 14 May 2001 12:17:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63672 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262248AbRENQRC>;
	Mon, 14 May 2001 12:17:02 -0400
Message-ID: <3B0004F7.4C54E2E4@mandrakesoft.com>
Date: Mon, 14 May 2001 12:16:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Manuel A. McLure" <mmt@unify.com>,
        "Rasmus =?iso-8859-1?Q?B=F8g?= Hansen" <moffe@amagerkollegiet.dk>,
        ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>,
        "Dunlap, Randy" <randy.dunlap@intel.com>,
        Martin Diehl <mdiehlcs@compuserve.de>,
        Adrian Cox <adrian@humboldt.co.uk>, Capricelli Thomas <orzel@kde.org>,
        Ian Bicking <ianb@colorstudy.com>, John R Lenton <john@grulic.org.ar>,
        Jens Dreger <Jens.Dreger@physik.fu-berlin.de>,
        David Hansen <David.Hansen@physik.fu-berlin.de>
Subject: Re: PATCH 2.4.5.1: Fix Via interrupt routing issues
In-Reply-To: <3AFEC426.50B00B78@mandrakesoft.com> <20010514172104.A2160@pua.nirvana>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Thimm wrote:
> 
> On Sun, May 13, 2001 at 01:28:06PM -0400, Jeff Garzik wrote:
> > For those of you with Via interrupting routing issues (or
> > interrupt-not-being-delivered issues, etc), please try out this patch
> > and let me know if it fixes things.  It originates from a tip from
> > Adrian Cox... thanks Adrian!
> 
> Unfortunately the patch does not trigger here. nr_ioapics is zero on my UP
> KT133A board. Was this patch for MP only?

Not for MP only, but mostly such:  UP systems with IO-APIC, or MP
systems.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
