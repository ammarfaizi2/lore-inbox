Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315554AbSENJOC>; Tue, 14 May 2002 05:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315555AbSENJOB>; Tue, 14 May 2002 05:14:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315554AbSENJOB>; Tue, 14 May 2002 05:14:01 -0400
Subject: Re: System Freeze
To: kosower@hotmail.com (David A. Kosower)
Date: Tue, 14 May 2002 10:33:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CE0A52E.F081EBB7@hotmail.com> from "David A. Kosower" at May 14, 2002 07:48:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177Ygg-0007W4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem occurs sporadically when netscape (4.78-2) tries to fetch a
> "complicated" page.  It does not occur reproducibly on any given page.
> A similar problem occurs so frequently with mozilla
> (mozilla-2002032709_trunk-0_rh7) as to render the latter unusable.  The
> system -- a Dell Inspiron 3500 -- is running Redhat 7.2
> (kernel-2.4.9-31), and is connected to the net via an ethernet
> PCMCIA talking to an Alcatel 1000 ADSL (which then obviously connects
> via ADSL).  Presumably this is also a sign of bugs in mozilla, but in
> any event whatever mozilla is doing should not trigger this.  There are
> no messages in /var/log/messages.

The app certain should never be able to trigger such a response.

> ppp_deflate            39104   0 (autoclean)
> bsd_comp                4224   0 (autoclean)
> ppp_async               6848   1 (autoclean)
> ppp_generic            19336   3 (autoclean) [ppp_deflate bsd_comp
> ppp_async]
> slhc                    5056   0 (autoclean) [ppp_generic]

You also have ppp loaded and a ppp link running ?

> pcnet_cs                9700   1
> 8390                    6176   0 [pcnet_cs]

What actual card do you have ? Also if you eject the card when the box
hangs does it unfreeze. My first thought is that it might be a problem
showing up under high network load

Alan
