Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135324AbRDLVOu>; Thu, 12 Apr 2001 17:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135325AbRDLVOj>; Thu, 12 Apr 2001 17:14:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61959 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135324AbRDLVOa>; Thu, 12 Apr 2001 17:14:30 -0400
Subject: Re: 8139too: defunct threads
To: andrewm@uow.edu.au (Andrew Morton)
Date: Thu, 12 Apr 2001 22:15:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stewart@dystopia.lab43.org (Rod Stewart), linux-kernel@vger.kernel.org,
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <3AD60D7F.1682DC7C@uow.edu.au> from "Andrew Morton" at Apr 12, 2001 01:18:07 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14noRa-0001VL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Plus it would mean that the kernel requires, for its
> correct operation, that process "1" is a child reaper.
> Is this a good thing?

That is already required. The rest of the reparenting functionality is also
in kernel/exit.c already

