Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291340AbSB0Brb>; Tue, 26 Feb 2002 20:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSB0BrV>; Tue, 26 Feb 2002 20:47:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:30668 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S291340AbSB0BrL>;
	Tue, 26 Feb 2002 20:47:11 -0500
Date: Tue, 26 Feb 2002 17:46:57 -0800
To: Jaroslav Kysela <perex@suse.cz>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH 2.5.5] Conversion of hp100 to new PCI interface
Message-ID: <20020226174657.A18197@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I depend on hp100, so I had to fix it and replace all those
virt_to_bus(). Only tested on a J2585B (PCI Busmaster). Other PCI and
ISA cards are *not* busmaster, so should not be affected. Some EISA
cards may be busmaster, but we would need to track down a tester...
	If the official maintainer doesn't have anything to
add, it would be nice if it could find its way in the kernel...
	Have fun...

	Jean
