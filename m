Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292971AbSBVTnD>; Fri, 22 Feb 2002 14:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292969AbSBVTmp>; Fri, 22 Feb 2002 14:42:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32774 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292970AbSBVTmZ>; Fri, 22 Feb 2002 14:42:25 -0500
Subject: Re: Flash Back -- kernel 2.1.111
To: andre@linuxdiskcert.org (Andre Hedrick)
Date: Fri, 22 Feb 2002 19:56:12 +0000 (GMT)
Cc: pmanuel@myrealbox.com (Pedro M. Rodrigues),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.10.10202221059340.32372-100000@master.linux-ide.org> from "Andre Hedrick" at Feb 22, 2002 11:03:48 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eLng-0002uy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does forcing a command to bypass the contents in the cache meaning
> anything.  This is not a cache sync like SCSI.  It is a cache bypass and
> will violate the journal on the down/commit block.

Thats a really useful option for a whole load of operations. Database folk
in paticular may well benefit as will O_DIRECT stuff
