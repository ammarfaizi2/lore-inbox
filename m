Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313064AbSC0S1y>; Wed, 27 Mar 2002 13:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313065AbSC0S1o>; Wed, 27 Mar 2002 13:27:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36370 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313064AbSC0S1k>; Wed, 27 Mar 2002 13:27:40 -0500
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Wed, 27 Mar 2002 18:16:16 +0000 (GMT)
Cc: zwane@linux.realnet.co.sz (Zwane Mwaikambo), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.GSO.3.96.1020327170918.8602K-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Mar 27, 2002 05:15:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qHy4-0005l7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > handler in fact only displays a warning, by which time the hardware is 
> > already handling the condition.
> 
>  How can't it be critical?  Your system is overheating.  It is about to
> fail -- depending on the configuration, it'll either crash or be shut down

Neither. It will drop to a much lower clock speed. You can set it to overheat
and blow up but thats a mostly undocumented mtrr 8) The default behaviour is
to throttle back hard

Alan
