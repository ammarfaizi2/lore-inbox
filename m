Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272991AbRIRRPb>; Tue, 18 Sep 2001 13:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273007AbRIRRPV>; Tue, 18 Sep 2001 13:15:21 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:531
	"EHLO awak") by vger.kernel.org with ESMTP id <S272991AbRIRRPQ>;
	Tue, 18 Sep 2001 13:15:16 -0400
Subject: 2.4.9-ac10 hangs on CDROM read error
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.04.53 (Preview Release)
Date: 18 Sep 2001 19:10:30 +0200
Message-Id: <1000833035.29346.11.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ABit VP6, CDRW as hdc and DVD as hdd (VIA vt82c686b IDE
driver), with SCSI emulation on top, and when I read either:

- a DVD with a read error in the DVD drive (UDF mounted, ripping)

- a CDR with a read error in the CDRW drive (ISO mounted)

the system hangs - no ping, no sysrq, nothing. no log.

I haven't tried all combinations (I don't like that). It seems like a
generic IDE CDROM driver bug, and there since several versions.

          Xav

