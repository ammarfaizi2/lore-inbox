Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272661AbTHKOeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272665AbTHKOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:34:24 -0400
Received: from matav-4.matav.hu ([145.236.252.35]:43062 "EHLO
	Forman.fw.matav.hu") by vger.kernel.org with ESMTP id S272661AbTHKOeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:34:21 -0400
Message-ID: <3F37A962.4030505@narancs.tii.matav.hu>
Date: Mon, 11 Aug 2003 16:34:10 +0200
From: narancs <narancs@narancs.tii.matav.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.3) Gecko/20030312
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DEC KZPSA SCSI card - is there a linux driver?
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I guess this mail should have gone to a mailing list like linux-scsi, 
but I just couldn't find that list's address - sorry if this mail is not 
to be here :)

so I have just got a DEC PCI SCSI card which has a sym53c720 chip and an 
intel 930 chip and an LSI chip on board. it is a full-length 32bit PCI 
scsi card. (it was working fine in an alpha axp system with true64 unix, 
and now it is installed in a PC.)

with linux kernel 2.4.20 (suse8.2) trying all the modules, I just 
couldn't get it working.
I moved the card to other PCI slots and play with irqs, but no success.

please help that which driver should get it working if this card is 
supported at all.

thanks!

00:0d.0 SCSI storage controller: Digital Equipment Corporation KZPSA [KZPSA]
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF+ FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 31750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 7
        BIST result: 00
        Region 0: Memory at fedfd000 (64-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at d000 [size=4K]
        Region 3: Memory at feb00000 (64-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=64K]


