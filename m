Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTKTGL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 01:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKTGLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 01:11:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:62607 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261433AbTKTGLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 01:11:25 -0500
X-Authenticated: #15936885
Message-ID: <3FBC5B04.50801@gmx.net>
Date: Thu, 20 Nov 2003 07:11:16 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: netdev@oss.sgi.com, Manfred Spraul <manfred@colorfullife.com>
Subject: forcedeth: version 0.18 available
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

version 0.18 of forcedeth for Linux 2.4 and 2.6 is available at
http://www.hailfinger.org/carldani/linux/patches/forcedeth/
It is also integrated in 2.6.0-test9-mm4.

Fixes in this release over 0.17:
*  Avoid Oops on rmmod.

Known issues:
*  Some boards give bogus MAC addresses and work only partially.
   Same problem happens with nvnet on these boards.
*  Possible system slowdown during periods of extreme network
   load, fix is currently being tested.

Please test.


Regards,
Carl-Daniel

