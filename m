Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129372AbRBLQxs>; Mon, 12 Feb 2001 11:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRBLQxi>; Mon, 12 Feb 2001 11:53:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4627 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129299AbRBLQxZ>; Mon, 12 Feb 2001 11:53:25 -0500
Subject: Re: Programmatically probe video chipset
To: moloch16@yahoo.com (Paul Powell)
Date: Mon, 12 Feb 2001 16:54:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010212164358.2762.qmail@web119.yahoomail.com> from "Paul Powell" at Feb 12, 2001 08:43:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SMEr-0007UM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there an API or other means to determine what video
> card, namely the chipset, that the user has installed
> on his machine?

On a modern X86 machine use the PCI/AGP bus data. On a PS/2 use the MCA bus
data. On nubus use the nubus probe data. On old style ISA bus PCs done a large
pointy hat and spend several years reading arcane and forbidden scrolls
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
