Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270252AbRHMPir>; Mon, 13 Aug 2001 11:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270254AbRHMPih>; Mon, 13 Aug 2001 11:38:37 -0400
Received: from [216.101.162.242] ([216.101.162.242]:8577 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270252AbRHMPiX>;
	Mon, 13 Aug 2001 11:38:23 -0400
Date: Mon, 13 Aug 2001 08:37:47 -0700 (PDT)
Message-Id: <20010813.083747.74740250.davem@redhat.com>
To: trini@kernel.crashing.org
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile of drivers/pci/pci.c in 2.4.9-pre2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010813083100.C9133@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20010813083100.C9133@cpe-24-221-152-185.az.sprintbbd.net>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tom Rini <trini@kernel.crashing.org>
   Date: Mon, 13 Aug 2001 08:31:00 -0700

   Hello.  2.4.9-pre2 introduced the mandatory PM transition delays for PCI
   devices.  However, it currently doesn't compile, at least on PPC, since
   drivers/pci/pci.c doesn't include <asm/delay.h> to get the definition of
   udelay.  Please apply this to the next release.  Thanks.

The correct include is <linux/delay.h> not <asm/delay.h>

Later,
David S. Miller
davem@redhat.com
