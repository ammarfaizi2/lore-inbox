Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131977AbRAGORy>; Sun, 7 Jan 2001 09:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRAGORo>; Sun, 7 Jan 2001 09:17:44 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61454 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131977AbRAGOR2>; Sun, 7 Jan 2001 09:17:28 -0500
Subject: Re: [PATCH] new bug report script
To: juchem@uni-mannheim.de
Date: Sun, 7 Jan 2001 14:19:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101071457540.7104-100000@gandalf.math.uni-mannheim.de> from "Matthias Juchem" at Jan 07, 2001 03:00:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGfM-0002jO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ./drivers/scsi/script_asm.pl
> ./drivers/usb/serial/ezusb_convert.pl
> ./arch/ppc/treeboot/elf.pl
> ./arch/arm/lib/extractconstants.pl
> ./scripts/checkconfig.pl
> ./scripts/checkhelp.pl
> ./scripts/checkincludes.pl

None of these are needed for normal build/use/bug reporting work. In fact
if you look at script_asm you'll see we go to great pains to ship prebuilt
files too

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
