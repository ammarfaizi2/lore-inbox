Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSBMJNc>; Wed, 13 Feb 2002 04:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291414AbSBMJNW>; Wed, 13 Feb 2002 04:13:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38662 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287045AbSBMJNM>; Wed, 13 Feb 2002 04:13:12 -0500
Subject: Re: 2.5.4 sound module problem
To: davem@redhat.com (David S. Miller)
Date: Wed, 13 Feb 2002 09:26:32 +0000 (GMT)
Cc: ac9410@bellsouth.net, alan@clueserver.org, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020212.202233.102575669.davem@redhat.com> from "David S. Miller" at Feb 12, 2002 08:22:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16avgO-0004j7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm, I don't it is safe to assume that only ISA sound drivers end up
> making use of this code.  I would like you to prove that before
> submitting this change.

There are PCI drivers using the old sound code. Whether it matters is a 
more complicated question as these devices use ISA DMA emulation or their
own pseudo DMA functionality.

Alan
