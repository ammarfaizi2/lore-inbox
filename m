Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289686AbSAJVPE>; Thu, 10 Jan 2002 16:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289684AbSAJVOx>; Thu, 10 Jan 2002 16:14:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23309 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289686AbSAJVOj>; Thu, 10 Jan 2002 16:14:39 -0500
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: pbadari@us.ibm.com (Badari Pulavarty)
Date: Thu, 10 Jan 2002 21:26:17 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200201102103.g0AL3Rr28448@eng2.beaverton.ibm.com> from "Badari Pulavarty" at Jan 10, 2002 01:03:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OmiH-0005ZV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Im just trying to work out how this deals with the 2.4 scsi case
> > 
> Alan,
> 
> I am lost ... What do you mean ? Could you please explain ?

The whole of scsi in 2.4 is effectively one block driver. 2.5 splits the
queues up really nicely.
