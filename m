Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbRENPWo>; Mon, 14 May 2001 11:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbRENPWZ>; Mon, 14 May 2001 11:22:25 -0400
Received: from thimm.dialup.fu-berlin.de ([160.45.217.207]:4100 "EHLO
	pua.physik.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S262128AbRENPWS>; Mon, 14 May 2001 11:22:18 -0400
Date: Mon, 14 May 2001 17:21:04 +0200
From: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Manuel A. McLure" <mmt@unify.com>,
        =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>,
        ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>,
        "Dunlap, Randy" <randy.dunlap@intel.com>,
        Martin Diehl <mdiehlcs@compuserve.de>,
        Adrian Cox <adrian@humboldt.co.uk>, Capricelli Thomas <orzel@kde.org>,
        Ian Bicking <ianb@colorstudy.com>, John R Lenton <john@grulic.org.ar>,
        Jens Dreger <Jens.Dreger@physik.fu-berlin.de>,
        David Hansen <David.Hansen@physik.fu-berlin.de>
Subject: Re: PATCH 2.4.5.1: Fix Via interrupt routing issues
Message-ID: <20010514172104.A2160@pua.nirvana>
In-Reply-To: <3AFEC426.50B00B78@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AFEC426.50B00B78@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, May 13, 2001 at 01:28:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 01:28:06PM -0400, Jeff Garzik wrote:
> For those of you with Via interrupting routing issues (or
> interrupt-not-being-delivered issues, etc), please try out this patch
> and let me know if it fixes things.  It originates from a tip from
> Adrian Cox... thanks Adrian!

Unfortunately the patch does not trigger here. nr_ioapics is zero on my UP
KT133A board. Was this patch for MP only?
-- 
Axel.Thimm@physik.fu-berlin.de
