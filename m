Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTACKM5>; Fri, 3 Jan 2003 05:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTACKM5>; Fri, 3 Jan 2003 05:12:57 -0500
Received: from [81.2.122.30] ([81.2.122.30]:40452 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267337AbTACKM4>;
	Fri, 3 Jan 2003 05:12:56 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301031020.h03AKV6N000674@darkstar.example.net>
Subject: IDE termination (was Re: UDMA 133 on a 40 pin cable)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 3 Jan 2003 10:20:31 +0000 (GMT)
Cc: Lionel.Bouton@inet6.fr, Teodor.Iacob@astral.kappa.ro,
       linux-kernel@vger.kernel.org
In-Reply-To: <1041559076.24830.116.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jan 03, 2003 01:57:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't think ATA66+ controllers can be within spec if they don't detect 
> > 40 vs 80 pin cables.
> 
> I wish. Alas not in the real world.

Something that occurs to me, which is somewhat related to this:

My understanding, (which might be wrong) is that termination of the
IDE bus is partly handled by each connected devicem rather like modern
floppy drives, (in contrast to SCSI, 10-base-2, old floppy drives etc,
where the termination is handled by devices at the physical ends of
the cable).

So if you connnect a really old IDE disk, say a 20 Mb one, and an
ATA-100 one to the same bus, is the termination then out of spec,
(analogous to using passive terminators on anything other than a SCSI-1
bus), because presumably the termination requirements are stricter for
the higher bus speed and signaling on both edges?

Just wondered.

John.
