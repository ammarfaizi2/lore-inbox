Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbSAZXJZ>; Sat, 26 Jan 2002 18:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287293AbSAZXJP>; Sat, 26 Jan 2002 18:09:15 -0500
Received: from ns.suse.de ([213.95.15.193]:2057 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287283AbSAZXIz>;
	Sat, 26 Jan 2002 18:08:55 -0500
Date: Sun, 27 Jan 2002 00:08:54 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: David Ford <david+cert@blue-labs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-dj5 linking error
In-Reply-To: <3C53346B.9020805@blue-labs.org>
Message-ID: <Pine.LNX.4.33.0201270007010.6332-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2002, David Ford wrote:

> drivers/scsi/scsidrv.o: In function `BusLogic_InterruptHandler':
> drivers/scsi/scsidrv.o(.text+0x10d65): undefined reference to
> `scsi_mark_host_reset'

That function got nuked in mainline for 2.5.1
Looks like the BusLogic driver needs to be brought up to speed
with the scsi/block changes.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

