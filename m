Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSFIUf2>; Sun, 9 Jun 2002 16:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSFIUf1>; Sun, 9 Jun 2002 16:35:27 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46862
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315178AbSFIUf0>; Sun, 9 Jun 2002 16:35:26 -0400
Date: Sun, 9 Jun 2002 13:33:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gert Vervoort <Gert.Vervoort@wxs.nl>
cc: linux-kernel@vger.kernel.org
Subject: FORMAT OPCODE == (Re: 2.5.21: "ata_task_file: unknown command 50")
In-Reply-To: <3D0358DD.DFBACA9E@wxs.nl>
Message-ID: <Pine.LNX.4.10.10206091328250.4658-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why the hell is the kernel sending down a low-level format command to
media?  How stupid can we get in writing a driver?  What next, modify the
microcode on the devices between boots and kernels?

Do backup between boots if this kind of crap is going in to the base
driver.  Even MircoSoft has more brains than to permit this rogue from
their product.

Andre Hedrick
LAD Storage Consulting Group

On Sun, 9 Jun 2002, Gert Vervoort wrote:

> 
> kernel 2.5.21 hangs with repeating the message "ata_task_file: unknown command 50" forever.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

