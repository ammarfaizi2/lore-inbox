Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314269AbSDVQ2A>; Mon, 22 Apr 2002 12:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314271AbSDVQ17>; Mon, 22 Apr 2002 12:27:59 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:8175 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314269AbSDVQ16>; Mon, 22 Apr 2002 12:27:58 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <UTC200204111400.OAA599785.aeb@cwi.nl> 
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net,
        linux-mtd@lists.infradead.org
Subject: Re: Flash device IDs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Apr 2002 17:25:51 +0100
Message-ID: <6448.1019492751@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andries.Brouwer@cwi.nl said:
> In include/linux/mtd/nand_ids.h there is some information about device
> IDs and device properties of NAND flash devices.

> In drivers/usb/storage/sddr09.c there is very similar information.
> Probably both tables should be merged.

Yes, probably. If the SDDR-09 lets you talk to the raw flash rather than 
doing the SmartMedia format for you in hardware/firmware then that support
probably also wants to be separated so it can be used on any hardware. 

--
dwmw2


