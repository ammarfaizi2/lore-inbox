Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKIBEn>; Wed, 8 Nov 2000 20:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKIBEe>; Wed, 8 Nov 2000 20:04:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:15242 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129047AbQKIBEW>;
	Wed, 8 Nov 2000 20:04:22 -0500
Date: Wed, 8 Nov 2000 16:49:19 -0800
Message-Id: <200011090049.QAA17420@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E13teE4-0000XI-00@the-village.bc.nu> (message from Alan Cox on
	Wed, 8 Nov 2000 23:01:50 +0000 (GMT))
Subject: Re: Linux 2.4.0test11pre1ac1
In-Reply-To: <E13teE4-0000XI-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 8 Nov 2000 23:01:50 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   o	Fix incorrect runtime panics in some scsi drivers

In drivers/scsi/fcal.c you correctly free "ages", in the
equivalent drivers/scsi/pluto.c fix you forget to do this.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
