Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292292AbSBUN3P>; Thu, 21 Feb 2002 08:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292372AbSBUN24>; Thu, 21 Feb 2002 08:28:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32004 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292292AbSBUN1X>; Thu, 21 Feb 2002 08:27:23 -0500
Subject: Re: more detailed information about the AMD 1.6+ GHz MP smp-problem
To: rob.myers@gtri.gatech.edu (Rob Myers)
Date: Thu, 21 Feb 2002 13:41:02 +0000 (GMT)
Cc: mw@suk.net, linux-kernel@vger.kernel.org
In-Reply-To: <1014291072.1243.81.camel@ransom> from "Rob Myers" at Feb 21, 2002 06:31:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dtT5-0006wD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> redhat's latest 2.4.9 version would only boot with noapic passed to the
> kernel and the bios had mps 1.4 spec on and mp table disabled. but
> sometimes that paniced and would not boot.
> 
> if anyone knows what bios settings and kernel bits make this board
> stable please pass that info along...

MP table on 
MP table version 1.1

You want 2.4.18-rc2 in order to get the fixups for what appears to be a BIOS
PCI compliance config problem. You also may need to remove any 3com gige
cards using broadcom chipsets.
