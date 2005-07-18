Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVGRQ0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVGRQ0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 12:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVGRQ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 12:26:25 -0400
Received: from dude3.usprocom.net ([69.222.0.8]:62988 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S261838AbVGRQ0Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 12:26:24 -0400
Date: Mon, 18 Jul 2005 11:26:49 -0500
Message-Id: <200507181126.AA81068656@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.12.3 ompilation errors with linux1394.org rev.1315
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.12.3 ompilation errors with linux1394.org rev.1315

[....]$ make && make modules
..........
LD      drivers/ieee1394/built-in.o
  CC [M]  drivers/ieee1394/ieee1394_core.o
drivers/ieee1394/ieee1394_core.c: In function ‘hpsbpkt_thread’:
drivers/ieee1394/ieee1394_core.c:1035: error: too few arguments to function ‘try_to_freeze’
drivers/ieee1394/ieee1394_core.c: In function ‘ieee1394_init’:
drivers/ieee1394/ieee1394_core.c:1113: warning: implicit declaration of function ‘class_create’
drivers/ieee1394/ieee1394_core.c:1113: warning: assignment makes pointer from integer without a cast
drivers/ieee1394/ieee1394_core.c:1151: warning: implicit declaration of function ‘class_destroy’
make[2]: *** [drivers/ieee1394/ieee1394_core.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2


xboom

