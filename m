Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275011AbTHQFjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 01:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275016AbTHQFjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 01:39:16 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:55424 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S275011AbTHQFjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 01:39:15 -0400
Date: Sat, 16 Aug 2003 22:37:34 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3-bk4 bug
Message-ID: <Pine.LNX.4.53.0308162231310.24851@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following is in -bk4 but not -bk3:

drivers/ide/pci/amd74xx.c: In function `amd74xx_get_info':
drivers/ide/pci/amd74xx.c:107: structure has no member named `name'
drivers/ide/pci/amd74xx.c: In function `init_chipset_amd74xx':
drivers/ide/pci/amd74xx.c:368: structure has no member named `name'
make[3]: *** [drivers/ide/pci/amd74xx.o] Error 1
make[2]: *** [drivers/ide/pci] Error 2
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2

Thanks,
  Russ
