Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbVKRNUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVKRNUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 08:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVKRNUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 08:20:17 -0500
Received: from outmx020.isp.belgacom.be ([195.238.2.201]:15244 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751330AbVKRNUQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 08:20:16 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.14.2] port smartcard driver to new pcmcia infrastructure?
Date: Fri, 18 Nov 2005 14:21:05 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511181421.05251.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I'm currently looking into getting my smartcard driver to work. O2Micro was 
nice enough to opensource the driver [1]. The driver compiles without 
problems, and can be insmod' without triggering any problem. The main problem 
lies that it doesn't seem to be calling the ozscrx_attach function, which 
sets up the irq's and everything, thus causing the subsequent open of the 
device to fail with -ENODEV.

The laptop in question is an Acer TM803, with an 
in-the-cardbus-system-integrated SmartCard reader.

Does anyone have any idea how i can continue debugging this?

Thanks.

Jan

[1] ftp://scrdriver:scrdriver@209.19.104.194/Linux or  
http://www.musclecard.com/drivers/readers/files/O2Micro_PCMCIA_SCR_202_Linux_Kernel26_OpenSource.tar.gz


-- 
Se o filme fosse gaúcho...

Mamãe Faz Cem anos -- A Véia tá Cheirando a Defunto 
