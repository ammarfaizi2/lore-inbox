Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbTL3Fz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTL3Fz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:55:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264367AbTL3FzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:55:24 -0500
Message-ID: <3FF11339.2000104@pobox.com>
Date: Tue, 30 Dec 2003 00:55:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [BK PATCHES] 2.6.x experimental net driver updates
Content-Type: multipart/mixed;
 boundary="------------050107060807060906000004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050107060807060906000004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Summary of new changes:
* bonding fixes
* e100/e1000 fixes
* other fixes
* via-rhine netpoll support


Summary of patchkit:
* new e100 driver (rewritten from scratch)
* new nVidia nForce NIC driver
* new pc200syn WAN driver

* tg3 bug fixes
* r8169 major bug fixes
* e1000 minor updates / fixes
* sk98lin vendor updates / fixes
* misc bug fixes

* 8139too NAPI support
* tulip NAPI support

* netconsole / netdump support
* net_device allocation and reference counting work


Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-bk2-netdrvr-exp1.patch.bz2
(NOTE: _requires_ 2.6.0-bk2 snapshot, or IOW Linus-latest from BK, in 
order to apply successfully)

Full changelog:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-bk2-netdrvr-exp1.log

BK repo:
bk://gkernel.bkbits.net/net-drivers-2.5-exp

Changelog delta attached.


--------------050107060807060906000004
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"


Alexander Viro:
  o [irda sa1100_ir] convert to using standard alloc_irdadev()

Amir Noam:
  o [netdrvr bonding] Add support for slaves that use ethtool_ops
  o [netdrvr bonding] Releasing the original active slave causes mac address duplication
  o [netdrvr bonding] Cannot remove and re-enslave the original active slave

Andrew Morton:
  o [netdrvr] new-probe warning fix

Jeff Garzik:
  o Merge redhat.com:/spare/repo/linux-2.5 into redhat.com:/spare/repo/net-drivers-2.5-exp
  o [netdrvr bonding] fix broken build

Pavel Machek:
  o [netdrvr via-rhine] add netpoll support

Russell King:
  o [irda sa1100_ir] "resurrect from bitrot hell"

Scott Feldman:
  o [netdrvr e1000] netpoll support
  o [netdrvr e1000] h/w workarounds + remove device ID
  o [netdrvr e100] netpoll + fixes to speed/duplex forced settings


--------------050107060807060906000004--

