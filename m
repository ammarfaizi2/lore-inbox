Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbULNSYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbULNSYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULNSYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:24:25 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:21129 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261588AbULNSYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:24:08 -0500
To: linux-kernel@vger.kernel.org
Cc: bzolnier@elka.pw.edu.pl (Bartlomiej Zolnierkiewicz)
Subject: Re: [BK PATCHES] ide-2.6 update
References: <200412102040.25133.bzolnier@elka.pw.edu.pl>
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Date: Tue, 14 Dec 2004 19:23:57 +0100
In-Reply-To: <200412102040.25133.bzolnier@elka.pw.edu.pl> (Bartlomiej
 Zolnierkiewicz's message of "Fri, 10 Dec 2004 20:40:25 +0100")
Message-ID: <878y8020xu.fsf@kosh.ultra.csn.tu-chemnitz.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: -4.9 () BAYES_00
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 3.0.1 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: bf792412a9282b88258c217492ac655a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bzolnier@elka.pw.edu.pl (Bartlomiej Zolnierkiewicz) writes:

> <bzolnier@trik.(none)> (04/12/10 1.2184)
>    [ide] atiixp: add new PCI identifier

* beside the new ID 1002:4369, the ID 4376 should be added also (both
  are ATA133 controllers driven by the same Windoze driver)

* ID 1002:4379 works with the same atiixp.c driver, but it is a SATA
  device. Although the SCSI layer should be used for SATA devices, is it
  be possible to use the IDE driver for now? Else, this chipset would be
  unsupported.

  The device is called "ATI 4379 Serial ATA Controller"

* The windoze driver lists the IDs :436E (both in the ATA133 and SATA
  driver)  and :437A (only SATA), but I never tested them.




Enrico
