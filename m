Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286878AbRLWMBO>; Sun, 23 Dec 2001 07:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286877AbRLWMBC>; Sun, 23 Dec 2001 07:01:02 -0500
Received: from zeus.city.tvnet.hu ([195.38.100.182]:64387 "EHLO
	zeus.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S286876AbRLWMAo>; Sun, 23 Dec 2001 07:00:44 -0500
Subject: via ide issue
From: Sipos Ferenc <sferi@dumballah.tvnet.hu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 23 Dec 2001 13:04:28 +0100
Message-Id: <1009109068.1438.11.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have an ASUS K7M mobo with via 686a chipset, my bios recognizes my hd
as udma4 capable, I have a dvd drive on the same ide channel as slave,
which is udma2 capable. Even if I give the kernel parameter: ide1=ata66,
(both drives are on the secondary channel) the hd switches back to udma3
mode, and by the dvd, dma is disabled, I have to switch it with hdparm.
Earlier kernels 2.4.4 and so, allowed me to switch to udma4 mode without
file corruption. So, I think, something must be done to correct the
driver problem. Any help appreciated. My current kernel is 2.4.17-rc2,
but the via driver has changed earlier, I think.

Paco 


