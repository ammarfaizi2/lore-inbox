Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274963AbRI1Ar4>; Thu, 27 Sep 2001 20:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274965AbRI1Arq>; Thu, 27 Sep 2001 20:47:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29203 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274963AbRI1Arf>; Thu, 27 Sep 2001 20:47:35 -0400
Subject: Re: apm suspend broken in 2.4.10
To: acruise@infowave.com (Alex Cruise)
Date: Fri, 28 Sep 2001 01:52:40 +0100 (BST)
Cc: rddunlap@osdlab.org ('Randy.Dunlap'),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81B0@earth.infowave.com> from "Alex Cruise" at Sep 27, 2001 04:56:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mltQ-0005fF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's possible... I got mine from kernel.org, applied the preemptible-kernel
> and ext3fs patches, and  compiled with RH's "kgcc" 

Don't build later 2.4.x with egcs-1.1.2. At least some of the network
drivers stop working mysteriously with < gcc 2.95.3, RH 2.96-74+ or 
gcc 3.0

Its not the cause of the APM problem but be aware of it
