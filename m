Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272149AbRHVWZl>; Wed, 22 Aug 2001 18:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272151AbRHVWZd>; Wed, 22 Aug 2001 18:25:33 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:60328 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S272149AbRHVWZV>; Wed, 22 Aug 2001 18:25:21 -0400
Message-ID: <71714C04806CD51193520090272892178BD4F3@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: jpr200012@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: dell inspiron 8000 eepro100 problems
Date: Wed, 22 Aug 2001 17:21:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i'm using 2.4.9 and have had a problem since 2.2
> kernels along with all versions of 2.4. i am having a
> problem with 2 laptops, both are dell inspiron 8000
> that have intel 82557 mini-pci nic in them. i get no

<Not official support>

Is the "sleep mode bit" set on the NIC?  Please try Donald Becker's
eepro100-diag.c program, located at
ftp://ftp.scyld.com/pub/diag/eepro100-diag.c, and use the -G -w -w -w flags
to clear that bit if running it first says that the sleep bit is enabled.
This may help.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
