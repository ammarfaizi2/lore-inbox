Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVCCCA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVCCCA3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVCCB7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:59:03 -0500
Received: from cgk192.neoplus.adsl.tpnet.pl ([83.30.238.192]:29319 "EHLO
	wenus.kolkowski.no-ip.org") by vger.kernel.org with ESMTP
	id S261278AbVCCBxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:53:42 -0500
Date: Thu, 3 Mar 2005 02:53:41 +0100
From: Damian Kolkowski <damian@kolkowski.no-ip.org>
To: linux-kernel@vger.kernel.org
Subject: [BUG] - SATA / ioctl(). (HDIO_GET_IDENTITY failed...)
Message-ID: <20050303015341.GENTOO-LINUX-ROX.B8468@kolkowski.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-GPG-Key: 0xB2C5DE03 (http://kolkowski.no-ip.org/damian.asc x-hkp://wwwkeys.eu.pgp.net)
X-Girl: 1 will be enough!
X-Age: 24 (1980.09.27 - libra)
X-IM: JID:deimos@chrome.pl ICQ:59367544 GG:88988
X-Operating-System: Gentoo Linux, kernel 2.6.11-gentoo, up 1 min
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any patch to correct libata working with ioctl()?

For example:

.~. # hdparm -t /dev/hda /dev/sda
/dev/hda:
 Timing buffered disk reads:  174 MB in  3.03 seconds =  57.36 MB/sec
/dev/sda:
 Timing buffered disk reads:  152 MB in  3.03 seconds =  50.11 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device
.~. #

I can attach addition: dmesg, kernel.config, lspci, etc...

take care.

-- 
### Damian Ko³kowski (dEiMoS) ## http://kolkowski.no-ip.org/ ###
# echo teb.cv-ba.vxfjbxybx.anvznq | rot13 | rev | sed s/\\./@/ #
