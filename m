Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285914AbRLHLcx>; Sat, 8 Dec 2001 06:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285915AbRLHLcn>; Sat, 8 Dec 2001 06:32:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47877 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285914AbRLHLcb>; Sat, 8 Dec 2001 06:32:31 -0500
Subject: Re: Some compiler warnings in 2.4.17-pre5
To: bunk@fs.tum.de (Adrian Bunk)
Date: Sat, 8 Dec 2001 11:37:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, dwmw2@infradead.org,
        emoenke@gwdg.de, jhartmann@precisioninsight.com,
        vmabraham@hotmail.com (Vineet M Abraham),
        dag@brattli.net (Dag Brattli), mid@auk.cx, jochen@scram.de,
        becker@scyld.com, elmer@ylenurme.ee, ajk@iehk.rwth-aachen.de
In-Reply-To: <Pine.NEB.4.43.0112070005300.8687-200000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at Dec 08, 2001 12:16:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Cfnh-00019h-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef MODULE
>  static Scsi_Host_Template driver_template = IPH5526_SCSI_FC;
> +#endif /* MODULE  */

The ifdefs are frequently uglier than the warning 8). The i820 one looks
most suspicious however.

Alan
