Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272539AbRH3XLE>; Thu, 30 Aug 2001 19:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272548AbRH3XKy>; Thu, 30 Aug 2001 19:10:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47621 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272539AbRH3XKq>; Thu, 30 Aug 2001 19:10:46 -0400
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
To: davem@redhat.com (David S. Miller)
Date: Fri, 31 Aug 2001 00:14:22 +0100 (BST)
Cc: kraxel@bytesex.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010830.160651.75218604.davem@redhat.com> from "David S. Miller" at Aug 30, 2001 04:06:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cb0w-00025m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When such an API would be created, it would take two PCI_DEV structs,
> and it would possibly fail.  On sparc64 for example, it is not
> possible to PCI peer-to-peer DMA between two PCI devices behind
> different PCI controllers, it simply doesn't work.

Thats an API video overlay really really needs of course - because DMA from
the capture card into the video memory is precisely how its done.

Alan
