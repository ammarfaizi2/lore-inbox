Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbTANTLq>; Tue, 14 Jan 2003 14:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTANTLq>; Tue, 14 Jan 2003 14:11:46 -0500
Received: from pelian.kabelfoon.nl ([62.45.46.43]:21255 "EHLO
	pelian.kabelfoon.nl") by vger.kernel.org with ESMTP
	id <S265081AbTANTLp>; Tue, 14 Jan 2003 14:11:45 -0500
Subject: I/O error
From: Christian Boon <cboon@kabelfoon.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Jan 2003 20:25:11 +0100
Message-Id: <1042572315.987.10.camel@client1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i continuously get the following messages in my dmesg, kernel 2.5.58 :

end_request: I/O error, dev hda, sector 0
end_request: I/O error, dev hda, sector 0
end_request: I/O error, dev hda, sector 0
end_request: I/O error, dev hda, sector 0

#cat /proc/ide/piix
Controller: 0

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    yes              no              yes               no
UDMA enabled:   yes              no              no                no
UDMA enabled:   2                X               X                 X
UDMA
DMA
PIO


# cat /proc/ide/hda/model
E-IDE 10X DVD-ROM DRIVE 0125

I got the messages too with 2.5.55, 2.5.56 and 2.5.57

Chris

