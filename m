Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129070AbRBBKJu>; Fri, 2 Feb 2001 05:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbRBBKJj>; Fri, 2 Feb 2001 05:09:39 -0500
Received: from adsl-216-102-91-127.dsl.snfc21.pacbell.net ([216.102.91.127]:1525
	"EHLO champ.drew.net") by vger.kernel.org with ESMTP
	id <S129070AbRBBKJX>; Fri, 2 Feb 2001 05:09:23 -0500
From: Drew Bertola <drew@drewb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.34641.120958.857239@champ.drew.net>
Date: Fri, 2 Feb 2001 10:09:21 +0000 ()
To: linux-kernel@vger.kernel.org
Subject: 2 SCSI controllers causing boot problems...
X-Mailer: VM 6.75 under Emacs 19.34.1
Reply-To: drew@drewb.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know I've seen this in the past, but the answer slips my mind and I
can't find anything in the archives.

I've just set up a box w/ an aic7xxx card.  The boot drive hangs off
that card.  During installation, the boot drive is sda.  Lilo contains
"root=/dev/sda8".  

I compiled a new kernel with the 3ware raid driver.  When I rebooted,
the 3ware card driver must have been loaded first; /dev/sda8 was no
longer the root device.

How do I control the device designations during boot?

-- 
Drew Bertola  | Send a text message to my pager or cell ... 
              |   http://jpager.com/Drew

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
