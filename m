Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314727AbSDVUbl>; Mon, 22 Apr 2002 16:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314729AbSDVUbk>; Mon, 22 Apr 2002 16:31:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61133 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314727AbSDVUbj>;
	Mon, 22 Apr 2002 16:31:39 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 22 Apr 2002 22:31:35 +0200 (MEST)
Message-Id: <UTC200204222031.g3MKVZq07564.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, dwmw2@infradead.org
Subject: Re: Flash device IDs
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        mdharm-usb@one-eyed-alien.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:

    Andries.Brouwer@cwi.nl said:
    > In include/linux/mtd/nand_ids.h there is some information about device
    > IDs and device properties of NAND flash devices.

    > In drivers/usb/storage/sddr09.c there is very similar information.
    > Probably both tables should be merged.

    Yes, probably. If the SDDR-09 lets you talk to the raw flash rather than 
    doing the SmartMedia format for you in hardware/firmware then that support
    probably also wants to be separated so it can be used on any hardware. 

Maybe you can look at ftp.XX.kernel.org people/aeb/*sddr09*.
I used identifiers nand_* when I thought things would be useful
for both (so that they should be outside of the usb tree).
Maybe we can find a suitable setup.

No, I am afraid this thing doesn't let me talk to raw flash,
or if it does, I have not yet discovered how.

Andries




