Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUHBUha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUHBUha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUHBUha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:37:30 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:55711 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263093AbUHBUh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:37:29 -0400
Message-ID: <410EA602.20201@t-online.de>
Date: Mon, 02 Aug 2004 22:37:22 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.7, amd64: sata_sil not in /proc/scsi?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XVMEL6ZEYeT0ZScpg3ppWBbl5GiQDAcGFDebrxKooDxEU4tAfRIN05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've got a mysterious effect breaking mkinitrd on my PC:

Even though sata_sil has been used to mount the root
partition, there is no /proc/scsi/sata_sil. But on
another PC, booting via aic7xxx, there is a
/proc/scsi/aic7xxx.

I should mention that sata_sil is a module, while aic7xxx
has been compiled into the kernel. But should this make
a difference?


Regards

Harri
