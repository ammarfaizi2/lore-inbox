Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSCTP1n>; Wed, 20 Mar 2002 10:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311646AbSCTP1d>; Wed, 20 Mar 2002 10:27:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62730 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311647AbSCTP1O>; Wed, 20 Mar 2002 10:27:14 -0500
Subject: Re: Hooks for random device entropy generation missing in cpqarray.c
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Wed, 20 Mar 2002 15:39:26 +0000 (GMT)
Cc: manon@manon.de (Manon Goo), arrays@compaq.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU,
        schroeder.markus@allianz.de (=?ISO-8859-1?Q?Markus_Schr=F6der?=)
In-Reply-To: <Pine.LNX.4.44.0203201630100.1268-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Mar 20, 2002 04:38:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16niBS-0002aE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Its all handled by drivers/scsi/scsi_lib.c, its a generic service so is 
> done for all drivers.

Thats only for scsi ones. cpqarray appears as a block device
