Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279918AbRJ3L1D>; Tue, 30 Oct 2001 06:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279919AbRJ3L0w>; Tue, 30 Oct 2001 06:26:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56593 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279918AbRJ3L0m>; Tue, 30 Oct 2001 06:26:42 -0500
Subject: Re: Ethernet NIC dual homing
To: ChemolliF@GruppoCredit.it ("Chemolli Francesco (USI)")
Date: Tue, 30 Oct 2001 11:33:31 +0000 (GMT)
Cc: deniel@worldnet.fr ('Laurent Deniel'), linux-kernel@vger.kernel.org
In-Reply-To: <E504453C04C1D311988D00508B2C5C2D01D813D9@mail11.gruppocredit.it> from "Chemolli Francesco (USI)" at Oct 30, 2001 12:05:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yX99-0006BI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Intel eepro100 cards, using Intel drivers (e100) and the ANS subsystem
> (all available from Intel for free - as in beer) allow this
> at the kernel-level, using link-detection to determine whether
> to fail over.

Any current 2.4 kernel with the bonding driver and the ethtool stuff will
do the job too. The only thing you do want to add is the Red Hat patch
for ethtool on eepro100, which should end up in -ac soon
