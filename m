Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTFOBjq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 21:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTFOBjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 21:39:46 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:62477 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S261769AbTFOBjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 21:39:45 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200306150153.VAA25928@clem.clem-digital.net>
Subject: 2.5.71 -- Lost second 3c509 card
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 14 Jun 2003 21:53:34 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.71, have lost second 3c509 card (i386 UP). 

>From kernel boot log with 2.5.71 get
   eth%%d: 3c5x9 at 0x300, BNC port, address  00 20 af 26 bf 2c, IRQ 10.

>From kernel boot log with 2.5.70 get
   eth0: 3c5x9 at 0x300, BNC port, address  00 20 af 26 bf 2c, IRQ 10.
   eth1: 3c5x9 at 0x310, 10baseT port, address  00 60 08 15 31 84, IRQ 9.

Checking on a single card system (SMP), the 
eth%%d: indication was introduced with 2.5.70-bk10.
-- 
Pete Clements 
clem@clem.clem-digital.net
