Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131113AbRCGWk6>; Wed, 7 Mar 2001 17:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbRCGWks>; Wed, 7 Mar 2001 17:40:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61704 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131113AbRCGWk3>; Wed, 7 Mar 2001 17:40:29 -0500
Subject: Re: Forcible removal of modules
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 7 Mar 2001 22:42:53 +0000 (GMT)
Cc: chief@bandits.org (John Fremlin), linux-kernel@vger.kernel.org,
        thood@excite.com
In-Reply-To: <3AA6951B.45FDBC1B@mandrakesoft.com> from "Jeff Garzik" at Mar 07, 2001 03:07:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ame0-0001o7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For PCI drivers, you implement the ::suspend and ::remove hooks.
> > I have a race free version of pm_send_all if you want it.
> Is this the same thing that is in 2.4.3-pre3?

Mine is race free for the basics, his is a far far more elegant solution to the
whole problem space. It might be 2.5 stuff but its definitely a good idea

