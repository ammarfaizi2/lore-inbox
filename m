Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272369AbRIWR7B>; Sun, 23 Sep 2001 13:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272522AbRIWR6v>; Sun, 23 Sep 2001 13:58:51 -0400
Received: from kiln.isn.net ([198.167.161.1]:31841 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S272369AbRIWR6l>;
	Sun, 23 Sep 2001 13:58:41 -0400
Message-ID: <3BAE2283.41E7E8E8@isn.net>
Date: Sun, 23 Sep 2001 14:57:23 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-pre15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: do we need 10 copies?
Content-Type: multipart/mixed;
 boundary="------------0217662F943E7089D94AB380"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0217662F943E7089D94AB380
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This table (512 bytes) and the code to implement crc-ccit is replicated
in 10 drivers. ppp-async even exports it. Surely there is a better way.
Garst
--------------0217662F943E7089D94AB380
Content-Type: text/plain; charset=us-ascii;
 name="dupcrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dupcrc"

arch/ppc/xmon/xmon.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
arch/ia64/sn/io/l1.c:      0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
drivers/net/hamradio/hdlcdrv.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
drivers/net/hamradio/baycom_epp.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
drivers/net/ppp_async.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
drivers/isdn/hisax/rawhdlc.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
drivers/isdn/hisax/netjet.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
drivers/isdn/hisax/st5481_hdlc.c:	0x0000,0x1189,0x2312,0x329b,0x4624,0x57ad,0x6536,0x74bf,
drivers/isdn/tpam/tpam_crcpc.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,
net/irda/crc.c:	0x0000, 0x1189, 0x2312, 0x329b, 0x4624, 0x57ad, 0x6536, 0x74bf,

--------------0217662F943E7089D94AB380--

