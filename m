Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290070AbSAQRLg>; Thu, 17 Jan 2002 12:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290072AbSAQRL3>; Thu, 17 Jan 2002 12:11:29 -0500
Received: from mail2.bnpparibas.com ([155.140.128.103]:21343 "EHLO
	lonn000936.uk.grp.intra") by vger.kernel.org with ESMTP
	id <S290070AbSAQRLL>; Thu, 17 Jan 2002 12:11:11 -0500
Subject: Problem compiling 2.5.2
To: linux-kernel@vger.kernel.org
From: bertrand.sirodot@bnpparibas.com
Date: Thu, 17 Jan 2002 17:11:07 +0000
Message-ID: <OF4B169642.EB12F9DB-ON80256B44.005DE9E3@bnpparibas.com>
X-MIMETrack: Serialize by Router on LONSMTP001/SERVERS/SMTP(Release 5.0.8 |June 18, 2001) at
 17/01/2002 17:04:12
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just downloaded 2.5.2 and was trying to compile it when I came
across some problems.
Please find below an extract of my session:
In file included from raid5.c:24:
/usr/src/linux/include/linux/raid/raid5.h:218: parse error before `md_wait_queue_head_t'
/usr/src/linux/include/linux/raid/raid5.h:218: warning: no semicolon at end of struct or union
/usr/src/linux/include/linux/raid/raid5.h:222: parse error before `device_lock'
/usr/src/linux/include/linux/raid/raid5.h:222: warning: type defaults to `int' in declaration of `device_lock'
/usr/src/linux/include/linux/raid/raid5.h:222: warning: data definition has no type or storage class
/usr/src/linux/include/linux/raid/raid5.h:226: parse error before `}'
raid5.c: In function `__release_stripe':
raid5.c:67: dereferencing pointer to incomplete type
raid5.c:71: dereferencing pointer to incomplete type
raid5.c:73: dereferencing pointer to incomplete type
raid5.c:74: dereferencing pointer to incomplete type
raid5.c:77: dereferencing pointer to incomplete type
raid5.c:78: dereferencing pointer to incomplete type
raid5.c:79: dereferencing pointer to incomplete type
raid5.c:81: dereferencing pointer to incomplete type
raid5.c:82: dereferencing pointer to incomplete type
raid5.c:83: dereferencing pointer to incomplete type
raid5.c:84: dereferencing pointer to incomplete type
raid5.c:85: dereferencing pointer to incomplete type
raid5.c: In function `release_stripe':
raid5.c:94: dereferencing pointer to incomplete type
raid5.c:96: dereferencing pointer to incomplete type
raid5.c: In function `insert_hash':
raid5.c:113: dereferencing pointer to incomplete type
raid5.c:113: dereferencing pointer to incomplete type
raid5.c:117: dereferencing pointer to incomplete type
raid5.c: In function `get_free_stripe':
raid5.c:131: dereferencing pointer to incomplete type
raid5.c:132: dereferencing pointer to incomplete type
raid5.c:134: dereferencing pointer to incomplete type
raid5.c:138: dereferencing pointer to incomplete type
raid5.c:129: warning: `first' might be used uninitialized in this function
raid5.c: In function `init_stripe':
raid5.c:189: dereferencing pointer to incomplete type
raid5.c:196: dereferencing pointer to incomplete type
raid5.c:202: dereferencing pointer to incomplete type
raid5.c: In function `shrink_stripe_cache':
raid5.c:226: dereferencing pointer to incomplete type
raid5.c:227: dereferencing pointer to incomplete type
raid5.c:231: dereferencing pointer to incomplete type
raid5.c: In function `__find_stripe':
raid5.c:240: dereferencing pointer to incomplete type
raid5.c:242: dereferencing pointer to incomplete type
raid5.c:242: dereferencing pointer to incomplete type
raid5.c:238: warning: `sh' might be used uninitialized in this function
raid5.c: In function `get_active_stripe':
raid5.c:255: warning: implicit declaration of function `md_spin_lock_irq'
raid5.c:255: dereferencing pointer to incomplete type
raid5.c:258: dereferencing pointer to incomplete type
raid5.c:259: dereferencing pointer to incomplete type
raid5.c:268: dereferencing pointer to incomplete type
raid5.c:273: dereferencing pointer to incomplete type
raid5.c:273: dereferencing pointer to incomplete type
raid5.c:273: dereferencing pointer to incomplete type
raid5.c:273: dereferencing pointer to incomplete type
raid5.c:273: dereferencing pointer to incomplete type
raid5.c:273: dereferencing pointer to incomplete type
raid5.c:275: dereferencing pointer to incomplete type
raid5.c:275: dereferencing pointer to incomplete type
raid5.c:276: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:279: dereferencing pointer to incomplete type
raid5.c:284: dereferencing pointer to incomplete type
raid5.c:288: dereferencing pointer to incomplete type
raid5.c:294: dereferencing pointer to incomplete type
raid5.c:298: dereferencing pointer to incomplete type
raid5.c:303: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:308: dereferencing pointer to incomplete type
raid5.c:309: dereferencing pointer to incomplete type
raid5.c:318: dereferencing pointer to incomplete type
raid5.c:329: warning: implicit declaration of function `md_spin_unlock_irq'
raid5.c:329: dereferencing pointer to incomplete type
raid5.c: In function `grow_stripes':
raid5.c:345: dereferencing pointer to incomplete type
raid5.c:346: dereferencing pointer to incomplete type
raid5.c:352: dereferencing pointer to incomplete type
raid5.c: In function `shrink_stripes':
raid5.c:364: dereferencing pointer to incomplete type
raid5.c:366: dereferencing pointer to incomplete type
raid5.c:371: dereferencing pointer to incomplete type
raid5.c:373: dereferencing pointer to incomplete type
raid5.c: In function `raid5_end_read_request':
raid5.c:382: dereferencing pointer to incomplete type
raid5.c:397: dereferencing pointer to incomplete type
raid5.c:408: structure has no member named `b_reqnext'
raid5.c:409: structure has no member named `b_reqnext'
raid5.c:412: dereferencing pointer to incomplete type
raid5.c:421: dereferencing pointer to incomplete type
raid5.c: In function `raid5_end_write_request':
raid5.c:440: dereferencing pointer to incomplete type
raid5.c:453: warning: implicit declaration of function `md_spin_lock_irqsave'
raid5.c:453: dereferencing pointer to incomplete type
raid5.c:455: dereferencing pointer to incomplete type
raid5.c:459: warning: implicit declaration of function `md_spin_unlock_irqrestore'
raid5.c:459: dereferencing pointer to incomplete type
raid5.c: In function `raid5_build_block':
raid5.c:471: dereferencing pointer to incomplete type
raid5.c: In function `raid5_error':
raid5.c:490: dereferencing pointer to incomplete type
raid5.c:490: warning: value computed is not used
raid5.c:490: dereferencing pointer to incomplete type
raid5.c:501: dereferencing pointer to incomplete type
raid5.c:502: dereferencing pointer to incomplete type
raid5.c:503: dereferencing pointer to incomplete type
raid5.c:507: dereferencing pointer to incomplete type
raid5.c:515: dereferencing pointer to incomplete type
raid5.c:516: dereferencing pointer to incomplete type
raid5.c:521: dereferencing pointer to incomplete type
raid5.c:527: dereferencing pointer to incomplete type
raid5.c:536: dereferencing pointer to incomplete type
raid5.c:485: warning: `disk' might be used uninitialized in this function
raid5.c: In function `raid5_compute_sector':
raid5.c:557: dereferencing pointer to incomplete type
raid5.c:580: dereferencing pointer to incomplete type
raid5.c:582: dereferencing pointer to incomplete type
raid5.c:583: case label not within a switch statement
raid5.c:587: break statement not within loop or switch
raid5.c:588: case label not within a switch statement
raid5.c:592: break statement not within loop or switch
raid5.c:593: case label not within a switch statement
raid5.c:596: break statement not within loop or switch
raid5.c:597: case label not within a switch statement
raid5.c:600: break statement not within loop or switch
raid5.c:601: default label not within a switch statement
raid5.c:602: dereferencing pointer to incomplete type
raid5.c: In function `compute_block':
raid5.c:664: dereferencing pointer to incomplete type
raid5.c: In function `compute_parity':
raid5.c:692: dereferencing pointer to incomplete type
raid5.c:712: structure has no member named `b_reqnext'
raid5.c:713: structure has no member named `b_reqnext'
raid5.c:724: structure has no member named `b_reqnext'
raid5.c:725: structure has no member named `b_reqnext'
raid5.c: In function `add_stripe_bh':
raid5.c:784: dereferencing pointer to incomplete type
raid5.c:785: structure has no member named `b_reqnext'
raid5.c:792: structure has no member named `b_reqnext'
raid5.c:795: dereferencing pointer to incomplete type
raid5.c: In function `handle_stripe':
raid5.c:826: dereferencing pointer to incomplete type
raid5.c:852: dereferencing pointer to incomplete type
raid5.c:855: dereferencing pointer to incomplete type
raid5.c:861: structure has no member named `b_reqnext'
raid5.c:862: structure has no member named `b_reqnext'
raid5.c:876: dereferencing pointer to incomplete type
raid5.c:891: structure has no member named `b_reqnext'
raid5.c:892: structure has no member named `b_reqnext'
raid5.c:896: dereferencing pointer to incomplete type
raid5.c:897: dereferencing pointer to incomplete type
raid5.c:900: structure has no member named `b_reqnext'
raid5.c:901: structure has no member named `b_reqnext'
raid5.c:904: dereferencing pointer to incomplete type
raid5.c:909: dereferencing pointer to incomplete type
raid5.c:919: dereferencing pointer to incomplete type
raid5.c:926: dereferencing pointer to incomplete type
raid5.c:934: structure has no member named `b_reqnext'
raid5.c:935: structure has no member named `b_reqnext'
raid5.c:958: dereferencing pointer to incomplete type
raid5.c:964: structure has no member named `b_reqnext'
raid5.c:973: dereferencing pointer to incomplete type
raid5.c:989: dereferencing pointer to incomplete type
raid5.c:999: dereferencing pointer to incomplete type
raid5.c:1011: dereferencing pointer to incomplete type
raid5.c:1030: dereferencing pointer to incomplete type
raid5.c:1053: dereferencing pointer to incomplete type
raid5.c:1058: dereferencing pointer to incomplete type
raid5.c:1059: dereferencing pointer to incomplete type
raid5.c:1060: dereferencing pointer to incomplete type
raid5.c:1102: dereferencing pointer to incomplete type
raid5.c:1103: dereferencing pointer to incomplete type
raid5.c:1104: dereferencing pointer to incomplete type
raid5.c:1110: dereferencing pointer to incomplete type
raid5.c:1118: structure has no member named `b_reqnext'
raid5.c:1119: structure has no member named `b_reqnext'
raid5.c:1123: structure has no member named `b_reqnext'
raid5.c:1124: structure has no member named `b_reqnext'
raid5.c:1130: dereferencing pointer to incomplete type
raid5.c:1136: dereferencing pointer to incomplete type
raid5.c:1137: dereferencing pointer to incomplete type
raid5.c:1145: structure has no member named `b_rdev'
raid5.c:1146: structure has no member named `b_rsector'
raid5.c:1147: warning: passing arg 1 of `generic_make_request' makes pointer from integer without a cast
raid5.c:1147: too many arguments to function `generic_make_request'
raid5.c: In function `raid5_activate_delayed':
raid5.c:1158: dereferencing pointer to incomplete type
raid5.c:1159: dereferencing pointer to incomplete type
raid5.c:1160: dereferencing pointer to incomplete type
raid5.c:1166: dereferencing pointer to incomplete type
raid5.c:1167: dereferencing pointer to incomplete type
raid5.c: In function `raid5_unplug_device':
raid5.c:1176: dereferencing pointer to incomplete type
raid5.c:1180: dereferencing pointer to incomplete type
raid5.c:1181: dereferencing pointer to incomplete type
raid5.c:1183: dereferencing pointer to incomplete type
raid5.c: In function `raid5_plug_device':
raid5.c:1188: dereferencing pointer to incomplete type
raid5.c:1189: dereferencing pointer to incomplete type
raid5.c:1190: dereferencing pointer to incomplete type
raid5.c:1191: dereferencing pointer to incomplete type
raid5.c:1192: dereferencing pointer to incomplete type
raid5.c:1194: dereferencing pointer to incomplete type
raid5.c: In function `raid5_make_request':
raid5.c:1200: dereferencing pointer to incomplete type
raid5.c:1213: structure has no member named `b_rsector'
raid5.c: In function `raid5_sync_request':
raid5.c:1235: dereferencing pointer to incomplete type
raid5.c:1240: dereferencing pointer to incomplete type
raid5.c: In function `raid5d':
raid5.c:1274: dereferencing pointer to incomplete type
raid5.c:1285: dereferencing pointer to incomplete type
raid5.c:1289: dereferencing pointer to incomplete type
raid5.c:1290: dereferencing pointer to incomplete type
raid5.c:1291: dereferencing pointer to incomplete type
raid5.c:1292: dereferencing pointer to incomplete type
raid5.c:1295: dereferencing pointer to incomplete type
raid5.c:1298: dereferencing pointer to incomplete type
raid5.c:1305: dereferencing pointer to incomplete type
raid5.c:1311: dereferencing pointer to incomplete type
raid5.c:1315: dereferencing pointer to incomplete type
raid5.c:1287: warning: `first' might be used uninitialized in this function
raid5.c: In function `raid5syncd':
raid5.c:1328: dereferencing pointer to incomplete type
raid5.c:1330: dereferencing pointer to incomplete type
raid5.c:1332: dereferencing pointer to incomplete type
raid5.c:1340: dereferencing pointer to incomplete type
raid5.c: In function `raid5_run':
raid5.c:1364: sizeof applied to an incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1368: dereferencing pointer to incomplete type
raid5.c:1370: dereferencing pointer to incomplete type
raid5.c:1370: warning: implicit declaration of function `md__get_free_pages'
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1374: dereferencing pointer to incomplete type
raid5.c:1374: `MD_SPIN_LOCK_UNLOCKED' undeclared (first use in this function)
raid5.c:1374: (Each undeclared identifier is reported only once
raid5.c:1374: for each function it appears in.)
raid5.c:1375: warning: implicit declaration of function `md_init_waitqueue_head'
raid5.c:1375: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1379: dereferencing pointer to incomplete type
raid5.c:1380: dereferencing pointer to incomplete type
raid5.c:1381: dereferencing pointer to incomplete type
raid5.c:1383: dereferencing pointer to incomplete type
raid5.c:1384: dereferencing pointer to incomplete type
raid5.c:1385: dereferencing pointer to incomplete type
raid5.c:1386: dereferencing pointer to incomplete type
raid5.c:1390: warning: assignment from incompatible pointer type
raid5.c:1390: dereferencing pointer to incomplete type
raid5.c:1390: dereferencing pointer to incomplete type
raid5.c:1390: warning: left-hand operand of comma expression has no effect
raid5.c:1398: dereferencing pointer to incomplete type
raid5.c:1438: dereferencing pointer to incomplete type
raid5.c:1458: dereferencing pointer to incomplete type
raid5.c:1461: dereferencing pointer to incomplete type
raid5.c:1474: dereferencing pointer to incomplete type
raid5.c:1478: dereferencing pointer to incomplete type
raid5.c:1478: dereferencing pointer to incomplete type
raid5.c:1478: dereferencing pointer to incomplete type
raid5.c:1479: dereferencing pointer to incomplete type
raid5.c:1480: dereferencing pointer to incomplete type
raid5.c:1481: dereferencing pointer to incomplete type
raid5.c:1482: dereferencing pointer to incomplete type
raid5.c:1483: dereferencing pointer to incomplete type
raid5.c:1493: dereferencing pointer to incomplete type
raid5.c:1493: dereferencing pointer to incomplete type
raid5.c:1494: dereferencing pointer to incomplete type
raid5.c:1497: dereferencing pointer to incomplete type
raid5.c:1498: dereferencing pointer to incomplete type
raid5.c:1501: dereferencing pointer to incomplete type
raid5.c:1502: dereferencing pointer to incomplete type
raid5.c:1502: dereferencing pointer to incomplete type
raid5.c:1506: dereferencing pointer to incomplete type
raid5.c:1514: dereferencing pointer to incomplete type
raid5.c:1515: dereferencing pointer to incomplete type
raid5.c:1521: dereferencing pointer to incomplete type
raid5.c:1522: dereferencing pointer to incomplete type
raid5.c:1523: dereferencing pointer to incomplete type
raid5.c:1525: dereferencing pointer to incomplete type
raid5.c:1537: dereferencing pointer to incomplete type
raid5.c:1539: dereferencing pointer to incomplete type
raid5.c:1543: dereferencing pointer to incomplete type
raid5.c:1546: dereferencing pointer to incomplete type
raid5.c:1546: dereferencing pointer to incomplete type
raid5.c:1548: dereferencing pointer to incomplete type
raid5.c:1548: dereferencing pointer to incomplete type
raid5.c:1553: dereferencing pointer to incomplete type
raid5.c:1554: dereferencing pointer to incomplete type
raid5.c:1560: dereferencing pointer to incomplete type
raid5.c:1561: dereferencing pointer to incomplete type
raid5.c:1574: dereferencing pointer to incomplete type
raid5.c:1575: dereferencing pointer to incomplete type
raid5.c: In function `raid5_stop_resync':
raid5.c:1588: dereferencing pointer to incomplete type
raid5.c:1591: dereferencing pointer to incomplete type
raid5.c:1592: dereferencing pointer to incomplete type
raid5.c: In function `raid5_restart_resync':
raid5.c:1606: dereferencing pointer to incomplete type
raid5.c:1607: dereferencing pointer to incomplete type
raid5.c:1612: dereferencing pointer to incomplete type
raid5.c:1613: dereferencing pointer to incomplete type
raid5.c: In function `raid5_stop':
raid5.c:1625: dereferencing pointer to incomplete type
raid5.c:1626: dereferencing pointer to incomplete type
raid5.c:1627: dereferencing pointer to incomplete type
raid5.c:1628: dereferencing pointer to incomplete type
raid5.c:1629: dereferencing pointer to incomplete type
raid5.c: In function `raid5_status':
raid5.c:1678: dereferencing pointer to incomplete type
raid5.c:1678: dereferencing pointer to incomplete type
raid5.c:1679: dereferencing pointer to incomplete type
raid5.c:1680: dereferencing pointer to incomplete type
raid5.c: In function `print_raid5_conf':
raid5.c:1700: dereferencing pointer to incomplete type
raid5.c:1701: dereferencing pointer to incomplete type
raid5.c:1701: dereferencing pointer to incomplete type
raid5.c:1706: dereferencing pointer to incomplete type
raid5.c:1706: dereferencing pointer to incomplete type
raid5.c:1708: dereferencing pointer to incomplete type
raid5.c: In function `raid5_diskop':
raid5.c:1727: dereferencing pointer to incomplete type
raid5.c:1739: dereferencing pointer to incomplete type
raid5.c:1740: dereferencing pointer to incomplete type
raid5.c:1751: dereferencing pointer to incomplete type
raid5.c:1765: dereferencing pointer to incomplete type
raid5.c:1766: dereferencing pointer to incomplete type
raid5.c:1782: dereferencing pointer to incomplete type
raid5.c:1801: dereferencing pointer to incomplete type
raid5.c:1802: dereferencing pointer to incomplete type
raid5.c:1821: dereferencing pointer to incomplete type
raid5.c:1826: dereferencing pointer to incomplete type
raid5.c:1829: dereferencing pointer to incomplete type
raid5.c:1835: dereferencing pointer to incomplete type
raid5.c:1841: dereferencing pointer to incomplete type
raid5.c:1842: dereferencing pointer to incomplete type
raid5.c:1852: dereferencing pointer to incomplete type
raid5.c:1857: dereferencing pointer to incomplete type
raid5.c:1858: dereferencing pointer to incomplete type
raid5.c:1938: dereferencing pointer to incomplete type
raid5.c:1939: dereferencing pointer to incomplete type
raid5.c:1940: dereferencing pointer to incomplete type
raid5.c:1945: dereferencing pointer to incomplete type
raid5.c:1947: dereferencing pointer to incomplete type
raid5.c:1958: dereferencing pointer to incomplete type
raid5.c:1985: dereferencing pointer to incomplete type
raid5.c:1719: warning: `i' might be used uninitialized in this function
raid5.c:1721: warning: `tmp' might be used uninitialized in this function
raid5.c:1721: warning: `sdisk' might be used uninitialized in this function
raid5.c:1721: warning: `adisk' might be used uninitialized in this function
raid5.c: At top level:
raid5.c:1993: warning: initialization from incompatible pointer type
raid5.c:2002: warning: initialization from incompatible pointer type
raid5.c:2004: parse error before `raid5_init'
raid5.c:2005: warning: return type defaults to `int'

I had a first look and it seems that quite a few words have been prefixed with md (like md__init, or md_spinlock_t).
I had a look at the raid0.c and raid1.c files and they don't use those md prefixed words.
It also seems that some errors have to do with the struct buffer_head missing some members.

Any ideas anybody?

Cheers.
Bertrand.



This message and any attachments (the "message") is
intended solely for the addressees and is confidential. 
If you receive this message in error, please delete it and 
immediately notify the sender. Any use not in accord with 
its purpose, any dissemination or disclosure, either whole 
or partial, is prohibited except formal approval. The internet
can not guarantee the integrity of this message. 
BNP PARIBAS (and its subsidiaries) shall (will) not 
therefore be liable for the message if modified. 

                ---------------------------------------------

Ce message et toutes les pieces jointes (ci-apres le 
"message") sont etablis a l'intention exclusive de ses 
destinataires et sont confidentiels. Si vous recevez ce 
message par erreur, merci de le detruire et d'en avertir 
immediatement l'expediteur. Toute utilisation de ce 
message non conforme a sa destination, toute diffusion 
ou toute publication, totale ou partielle, est interdite, sauf 
autorisation expresse. L'internet ne permettant pas 
d'assurer l'integrite de ce message, BNP PARIBAS (et ses
filiales) decline(nt) toute responsabilite au titre de ce 
message, dans l'hypothese ou il aurait ete modifie.

