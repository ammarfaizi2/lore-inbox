Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbUCTL7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 06:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbUCTL7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 06:59:44 -0500
Received: from dsl81-215-37317.adsl.ttnet.net.tr ([81.215.145.197]:14208 "EHLO
	hightemple.highland") by vger.kernel.org with ESMTP id S263382AbUCTL7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 06:59:42 -0500
From: Tarkan Erimer <tarkane@solmaz.com.tr>
To: linux-kernel@vger.kernel.org
Subject: [BUG]: BIND fails to start with 2.6.4[5-rc1]
Date: Sat, 20 Mar 2004 13:57:16 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cGDXArwyYrSSqaE"
Message-Id: <200403201357.16203.tarkane@solmaz.com.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_cGDXArwyYrSSqaE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

H=C4=B0,

I  have an interesting problem. BIND (BIND 9.2.3) is not working with=20
linux-2.6.4 and linux-2.6.5-rc1 (haven't tried linux-2.6.5-rc2, yet). But=20
linux-2.6.4-rc2 works fine with BIND. When the system boots and starts=20
BIND daemon, I got the following error message:

Starting BIND:  /usr/sbin/named
named: capset failed: Operation not permitted

By the way, I'm using Slackware 9.1. Also, my ver_linux output attached=20
to this mail.

Regards

--Boundary-00=_cGDXArwyYrSSqaE
Content-Type: text/plain;
  charset="utf-8";
  name="ver_linux.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ver_linux.out"

bash-2.05b# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux hightemple 2.6.5-rc1 #1 Fri Mar 19 23:11:03 EET 2004 i686 unknown unknown GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
jfsutils               1.1.3
xfsprogs               2.5.6
pcmcia-cs              3.2.5
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0.91
Modules Loaded         rfcomm snd_mixer_oss snd l2cap hci_usb bluetooth uhci_hcd ohci_hcd nvidia sb sb_lib uart401 sound soundcore sg sd_mod ide_scsi 3c59x usb_storage usbcore scsi_mod agpgart apm reiserfs
bash-2.05b#
--Boundary-00=_cGDXArwyYrSSqaE--
