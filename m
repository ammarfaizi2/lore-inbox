Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTKPX0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 18:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTKPX0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 18:26:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:4236 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263189AbTKPX0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 18:26:41 -0500
X-Authenticated: #15936885
Message-ID: <3FB807A3.8010207@gmx.net>
Date: Mon, 17 Nov 2003 00:26:27 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: netdev@oss.sgi.com, Andrew Morton <akpm@digeo.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       Andrew de Quincey <adq@lidskialf.net>,
       Manfred Spraul <manfred@colorfullife.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: forcedeth: version 0.17 available
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

version 0.17 of forcedeth for Linux 2.4 and 2.6 is available at
http://www.hailfinger.org/carldani/linux/patches/forcedeth/

Fixes in this release over 0.14:
*  0.15: 08 Nov 2003: fix smp deadlock with set_multicast_list
*                     during open.
*  0.16: 15 Nov 2003: include file cleanup for ppc64, rx buffer
*                     size increased to 1628 bytes.
*  0.17: 16 Nov 2003: undo rx buffer size increase. Substract 1
*                     from the tx length.

Known issues:
*  Oops during module removal, probably sysfs related. Could a
   sysfs expert please take a look at the code? Call trace is at
   http://www.ussg.iu.edu/hypermail/linux/kernel/0311.1/0213.html
   More traces (roughly the same) available on request.
*  Some boards give bogus MAC addresses and work only partially.
   Same problem happens with nvnet on these boards.
*  Transmit for packets close to MTU size was broken, should be
   fixed now.

Please test.


Regards,
Carl-Daniel

