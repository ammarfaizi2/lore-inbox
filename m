Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTK0QIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTK0QIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:08:17 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:44776 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264535AbTK0QIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:08:15 -0500
Subject: Re: Hp/Compaq Fibre HBA
From: Danny Brow <fms@istop.com>
To: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Cc: Kernel-Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <016501c3b4d5$aa4b2130$2987110a@lsd.css.fujitsu.com>
References: <20031126110558.16044.qmail@web13906.mail.yahoo.com>
	 <016501c3b4d5$aa4b2130$2987110a@lsd.css.fujitsu.com>
Content-Type: text/plain
Message-Id: <1069949135.24875.11.camel@zeus.fullmotionsolutions.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 27 Nov 2003 11:05:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is all the information on the card.

Tachyon
HPFC-5000c/3.0
L2A0729

&

NEC
Compaq 194789-002
UPD65806GD-071
9733PU003



On Thu, 2003-11-27 at 06:00, Hironobu Ishii wrote:
> Hi Dan and Martin,
> 
> 
> > >Did I send this question to the wrong group?
> > >
> > >On Mon, 2003-11-24 at 13:18, Danny Brow wrote:
> > >> Any one know if there are drivers for a storageworks fibre channel
> > host
> > >> bus adapter /p. The chip set is Tachyon HPFC-5000c/3.0, the card
> > also
> > >> has this number on it HHBA - 5000A.
> > >>
> > >> TIA,
> > >>
> > >> Dan.
> > >>
> > Dan,
> 
> I'm afraid there is no linux driver for that card.
> Agilent calls HPFC-5000C as "Classic Tachyon".
> 
> "drivers/net/fc" is a driver that controls Classic Tachyon.
> But I don't know whether it works as SCSI driver.
> (I'm afraid it doesn't.)
> Basically, it's a driver for Interphase 5526 PCI FC card.
> 
> Classic Tachyon has a TSI(Tachyon System Interface) bus.
> So every Classic Tachyon based PCI-HBA has its own bus bridge chip.
> 
> Interphase's bridge chip was called as i-chip.
> If HHBA-5000A uses a i-chip as a bridge, you might be able to use
> that driver.
> Are there any Interphase logo on HHBA-5000A?
> 
> > 
> >  not sure about the group. Maybe it is just that nobody has a good
> > answer. I was having similar problems with regard to another Tachyon
> > [XL2]based HP card.Lack of Linux support prevented basically a working
> > dual-boot solution (HP-UX vs. Linux) on couple of rx5670 boxes.
> > 
> >  At that time a nice folk at HP basically told me that: "it could be
> > done, but we are looking for funding one or two consultants".
> > 
> >  One of the problems involved seems to be documentation on the Tachyon
> > chips. As usual.  Another reason (for those liking conspiracy theories)
> > might be market(ing) segmentation by HP. But I'm just being paranoid
> > here :-)
> > 
> > Martin
> > PS: have a look at http://sourceforge.net/projects/cpqfc - but I fear
> > it is not very actively maintained :-(
> 
> cpqfc is a driver for Tachyon TL/TS(HPFC-51xx), XL2(HPFC-5200) and
> DX2(HPFC-5400).
> 
> 
> Hironobu Ishii.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

