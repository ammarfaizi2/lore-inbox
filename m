Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279394AbRKFOEE>; Tue, 6 Nov 2001 09:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279378AbRKFOD4>; Tue, 6 Nov 2001 09:03:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28169 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279412AbRKFODp>; Tue, 6 Nov 2001 09:03:45 -0500
Subject: Re: [PATCH] PnPBIOS patch #11
To: jdthood@mail.com (Thomas Hood)
Date: Tue, 6 Nov 2001 14:10:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1005054783.20875.37.camel@thanatos> from "Thomas Hood" at Nov 06, 2001 08:53:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1616wF-0000bs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + *
> + * Note that it is currently assumed that the list does not
> + * grow or shrink in size after init time, and slot_name
> + * never changes.

Please dont code on that basis. I added the locks and the like so that
when I get a docking event I can eventually rescan the pnpbios data and
hot plug/unplug devices

