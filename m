Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135682AbRD2Grk>; Sun, 29 Apr 2001 02:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135680AbRD2GrV>; Sun, 29 Apr 2001 02:47:21 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:50189 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135571AbRD2GrJ>;
	Sun, 29 Apr 2001 02:47:09 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac*, 2.4.4, tc/lk201 files missing
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Apr 2001 16:47:02 +1000
Message-ID: <32737.988526822@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both 2.4.3-ac* and 2.4.4 have this in drivers/tc/Makefile

obj-$(CONFIG_VT) += lk201.o lk201-map.o lk201-remap.o
lk201-map.c: lk201-map.map
        loadkeys --mktable lk201-map.map > lk201-map.c

None of lk201.c, lk201-remap.c, lk201-map.map are in the kernel tree.
Where are these missing files?

