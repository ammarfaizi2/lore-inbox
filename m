Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310848AbSCHM6y>; Fri, 8 Mar 2002 07:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310840AbSCHM6h>; Fri, 8 Mar 2002 07:58:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13579 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310842AbSCHM6O>; Fri, 8 Mar 2002 07:58:14 -0500
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
To: arjan@fenrus.demon.nl (Arjan van de Ven)
Date: Fri, 8 Mar 2002 13:12:25 +0000 (GMT)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020308085028.A14375@fenrus.demon.nl> from "Arjan van de Ven" at Mar 08, 2002 08:50:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jKAb-00068h-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > RAID class devices at all. This would just prevent
> > us from having two different entries in the
> > device detection list. Not much more involved I think.
> 
> There's one tiny glitch: there are exactly 2 "real" raid devices out there
> (that I know of at least). But anyway, a "don't look at" list will be
> MUCH shorter than a "look also at" list.

Correct. Without the Supertrak series detection code in there anyone booting
a kernel will *really* upset their hardware raid array. Fortunately all
we have to do is to spot promise ide chips beyond an i960 as the current
code does.

Alan
