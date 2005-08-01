Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVHATX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVHATX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVHATX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:23:27 -0400
Received: from khc.piap.pl ([195.187.100.11]:1540 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261162AbVHATX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:23:26 -0400
To: Alexander Fieroch <fieroch@web.de>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Michael Thonke <iogl64nx@gmail.com>,
       linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Natalie.Protasevich@unisys.com, Andrew Morton <akpm@osdl.org>,
       Parag Warudkar <kaernel-stuff@comcast.net>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
References: <d6gf8j$jnb$1@sea.gmane.org> <42EAAFD4.4010303@web.de>
	<42EAD086.4010904@gmail.com>
	<200507291905.37339.kernel-stuff@comcast.net>
	<20050730014237.GA20131@mipter.zuzino.mipt.ru>
	<42EE33F6.6040606@web.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 01 Aug 2005 21:23:23 +0200
In-Reply-To: <42EE33F6.6040606@web.de> (Alexander Fieroch's message of "Mon,
 01 Aug 2005 16:38:46 +0200")
Message-ID: <m3oe8h7978.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Fieroch <fieroch@web.de> writes:

> hdb: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> hdb: media error (bad sector): error=0x30 { LastFailedSense=0x03 }
> ide: failed opcode was: unknown
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> end_request: I/O error, dev hdb, sector 1306960
> Buffer I/O error on device hdb, logical block 326740

BTW: I believe this used to point to something useful rather than
to "unknown opcode". Is it just a bug or does it really not know
the opcode?
-- 
Krzysztof Halasa
