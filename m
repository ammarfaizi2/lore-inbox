Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265203AbSJPQvd>; Wed, 16 Oct 2002 12:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265183AbSJPQuK>; Wed, 16 Oct 2002 12:50:10 -0400
Received: from dsl-linz6-241-136.utaonline.at ([212.152.241.136]:5874 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S265203AbSJPQsf>;
	Wed, 16 Oct 2002 12:48:35 -0400
Message-ID: <3DAD9880.4E98BCB6@falke.mail>
Date: Wed, 16 Oct 2002 18:49:04 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: sis fb compiler errors]
Content-Type: multipart/mixed;
 boundary="------------EC3BF0E3C045F91D33297C9A"
X-MDRemoteIP: 10.0.0.13
X-Return-Path: thomas@winischhofer.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EC3BF0E3C045F91D33297C9A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


I expect more messages of this sort now that 2.4.20pre11 is out. 

Sorry to say this, but it looks like Alan (again) forgot to sumbit the
updated sisfb.h file (from /include/linux) to Marcello along with the
rest of the updated code.

If anyone of you want to run sisfb in the meantime, go to
www.winischhofer.net/linuxsis630.shtml, download the sisfb source and
copy the file "sisfb.h" from the archive to [kernel-tree]/include/linux
(over the old one).

Thomas

-- 
Thomas Winischhofer
Vienna/Austria                 
mailto:thomas@winischhofer.net            http://www.winischhofer.net/
--------------EC3BF0E3C045F91D33297C9A
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from Pending... [127.0.0.1] by falke.mail [10.0.0.195]
	with MultiPOP (MDaemon.v3.5.7.R)
	for <tw@falke.mail>; Wed, 16 Oct 2002 18:16:37 +0200
Received: from server.smi-ps.com (www.smi-ps.com [194.224.14.130] (may be forged))
        by limes.webit.at (8.12.0.Beta16/8.12.0.Beta16/Debian 8.12.0.Beta16) with ESMTP id g9GGNgCq026580
        for <thomas@winischhofer.net>; Wed, 16 Oct 2002 18:23:43 +0200
Received: from wanadoo.es ([62.36.147.214]) by server.smi-ps.com
          (Netscape Messaging Server 4.15) with ESMTP id H431KI00.308 for
          <thomas@winischhofer.net>; Wed, 16 Oct 2002 18:24:18 +0200
Sender: xose
Message-ID: <3DAD917F.98B1A390@wanadoo.es>
Date: Wed, 16 Oct 2002 18:19:11 +0200
From: =?iso-8859-1?Q?Xos=E9=20V=E1zquez?= <xose@wanadoo.es>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-10 i686)
MIME-Version: 1.0
To: thomas@winischhofer.net
Subject: sis fb compiler errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by AMaViS-perl11-milter (http://amavis.org/)
X-MDRemoteIP: 127.0.0.1
X-MDRcpt-To: tw@falke.mail
X-MDaemon-Deliver-To: tw@falke.mail
X-Mozilla-Status2: 00000000

hi Thomas,

sis fb compiler errors with 2.4.20-pre11:

In file included from sis_main.c:67:
sis_main.h:348: parse error before `sisvga_engine'
sis_main.h:348: warning: type defaults to `int' in declaration of
`sisvga_engine'
sis_main.h:348: `UNKNOWN_VGA' undeclared here (not in a function)
sis_main.h:348: warning: data definition has no type or storage class
sis_main.h:363: parse error before `sisfbinfo'
sis_main.h:363: warning: type defaults to `int' in declaration of
`sisfbinfo'
sis_main.h:363: warning: data definition has no type or storage class
sis_main.c: In function `sisfb_validate_mode':
sis_main.c:316: `SIS_300_VGA' undeclared (first use in this function)
sis_main.c:316: (Each undeclared identifier is reported only once
sis_main.c:316: for each function it appears in.)
sis_main.c:323: `SIS_315_VGA' undeclared (first use in this function)
sis_main.c: In function `sis_getcolreg':
sis_main.c:500: structure has no member named `video_cmap_len'
sis_main.c: In function `sisfb_setcolreg':
sis_main.c:514: structure has no member named `video_cmap_len'
sis_main.c: In function `sisfb_do_set_var':
sis_main.c:666: structure has no member named `video_linelength'
sis_main.c:669: structure has no member named `DstColor'
sis_main.c:670: structure has no member named `SiS310_AccelDepth'
sis_main.c:671: structure has no member named `video_cmap_len'
sis_main.c:674: structure has no member named `DstColor'
sis_main.c:675: structure has no member named `SiS310_AccelDepth'
sis_main.c:676: structure has no member named `video_cmap_len'
sis_main.c:679: structure has no member named `DstColor'
sis_main.c:680: structure has no member named `SiS310_AccelDepth'
sis_main.c:681: structure has no member named `video_cmap_len'
sis_main.c:684: structure has no member named `video_cmap_len'
sis_main.c: In function `sisfb_do_install_cmap':
sis_main.c:802: structure has no member named `video_cmap_len'
sis_main.c: In function `sisfb_pan_var':
sis_main.c:837: `SIS_315_VGA' undeclared (first use in this function)
sis_main.c: In function `sisfb_crtc_to_var':
sis_main.c:886: structure has no member named `video_cmap_len'
sis_main.c:897: structure has no member named `video_cmap_len'
sis_main.c:908: structure has no member named `video_cmap_len'
sis_main.c:919: structure has no member named `video_cmap_len'
sis_main.c:1055: structure has no member named `heapstart'
sis_main.c: In function `sisfb_get_cmap':
sis_main.c:1120: structure has no member named `video_cmap_len'
sis_main.c: In function `sisfb_set_cmap':
sis_main.c:1134: structure has no member named `video_cmap_len'
sis_main.c: In function `sisfb_get_fix':
sis_main.c:1285: structure has no member named `video_linelength'
sis_main.c: In function `sisfb_ioctl':
sis_main.c:1391: structure has no member named `video_linelength'
sis_main.c:1394: structure has no member named `DstColor'
sis_main.c:1395: structure has no member named `SiS310_AccelDepth'
sis_main.c:1396: structure has no member named `video_cmap_len'
sis_main.c:1399: structure has no member named `DstColor'
sis_main.c:1400: structure has no member named `SiS310_AccelDepth'
sis_main.c:1401: structure has no member named `video_cmap_len'
sis_main.c:1404: structure has no member named `DstColor'
sis_main.c:1405: structure has no member named `SiS310_AccelDepth'
sis_main.c:1406: structure has no member named `video_cmap_len'
sis_main.c:1409: structure has no member named `video_cmap_len'
sis_main.c:1419: `SISFB_GET_INFO' undeclared (first use in this
function)
sis_main.c:1421: `sisfb_info' undeclared (first use in this function)
sis_main.c:1421: `x' undeclared (first use in this function)
sis_main.c:1421: parse error before `)'
sis_main.c:1423: `SISFB_ID' undeclared (first use in this function)
sis_main.c:1429: structure has no member named `heapstart'
sis_main.c: In function `SiS_Sense30x':
sis_main.c:2202: `SIS_300_VGA' undeclared (first use in this function)
sis_main.c: In function `sisfb_heap_init':
sis_main.c:2396: structure has no member named `heapstart'
sis_main.c:2398: structure has no member named `heapstart'
sis_main.c:2400: structure has no member named `heapstart'
sis_main.c:2403: structure has no member named `heapstart'
sis_main.c:2406: structure has no member named `heapstart'
sis_main.c:2408: structure has no member named `heapstart'
sis_main.c:2414: `SIS_315_VGA' undeclared (first use in this function)
sis_main.c:2586: `SIS_300_VGA' undeclared (first use in this function)
sis_main.c: In function `sisfb_post_setmode':
sis_main.c:2944: `SIS_300_VGA' undeclared (first use in this function)
sis_main.c:2959: `SIS_315_VGA' undeclared (first use in this function)
sis_main.c: In function `sisfb_init':
sis_main.c:3232: `SIS_300_VGA' undeclared (first use in this function)
sis_main.c:3259: `SIS_315_VGA' undeclared (first use in this function)
sis_main.c:3687: structure has no member named `video_linelength'
sis_main.c:3690: structure has no member named `DstColor'
sis_main.c:3691: structure has no member named `SiS310_AccelDepth'
sis_main.c:3692: structure has no member named `video_cmap_len'
sis_main.c:3695: structure has no member named `DstColor'
sis_main.c:3696: structure has no member named `SiS310_AccelDepth'
sis_main.c:3697: structure has no member named `video_cmap_len'
sis_main.c:3700: structure has no member named `DstColor'
sis_main.c:3701: structure has no member named `SiS310_AccelDepth'
sis_main.c:3702: structure has no member named `video_cmap_len'
sis_main.c:3705: structure has no member named `video_cmap_len'
sis_main.c:3790: `SISFB_GET_INFO' undeclared (first use in this
function)
make[3]: *** [sis_main.o] Error 1
make[2]: *** [_modsubdir_sis] Error 2
make[1]: *** [_modsubdir_video] Error 2
make: *** [_mod_drivers] Error 2

--
Antes vivia. Ahora tengo ordenador.



--------------EC3BF0E3C045F91D33297C9A--


