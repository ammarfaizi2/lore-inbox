Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267533AbUGWG5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267533AbUGWG5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 02:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUGWG5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 02:57:14 -0400
Received: from mail.wayne-europe.com ([217.237.173.114]:6673 "EHLO
	wayne-europe.com") by vger.kernel.org with ESMTP id S267533AbUGWG5N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 02:57:13 -0400
Message-Id: <04Jul23.090421cest.332187@gateway.wayne-europe.com>
From: Michael Thonke <MThonke@wayne-europe.com>
To: linux-kernel@vger.kernel.org
Subject: How to mapping Raid Mirror set on Promise PDC27x using device-map
	per
Date: Fri, 23 Jul 2004 08:57:52 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I hope someone could help me with device mapping on mirror raid set.
I tried to map my Promise Raid Mirroset with device mapper, but
I could not get it working the devmap.raid1 I used is
I compiled dm-mod linear mirror und dmcrypt as module for kernel

0 80043264 mirror core 1 1024 2 /dev/hde 0 /dev/hdg 0

to get the mirrored Raid but if I run dmsetup I got an error like

device-mapper ioctl cmd 3 faild: device or resource busy

Any hints how to set up the mirror set using device-mapper are welcome

Thanks for help

Mit freundlichen Grüßen
_______________________
Wayne Pignone
Dresser Europe GmbH
Organisation / Datenverarbeitung 
Michael Thonke 
Grimsehlstrasse 44
37574 Einbeck * Germany
Telefon +49 55 61- 794-168
Telefax +49 55 61- 794-224
<mailto:MThonke@wayne-europe.com>
<http://www.wayne-europe.com/>
_______________________
