Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWIIT1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWIIT1I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 15:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWIIT1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 15:27:08 -0400
Received: from mx6.mail.ru ([194.67.23.26]:33072 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S964806AbWIIT1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 15:27:05 -0400
From: Lefti <lefti@bk.ru>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_EDD=[ym] kernel doesn't start booting
Date: Sat, 9 Sep 2006 21:26:56 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609092126.56607.lefti@bk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have kernel with CONFIG_EDD=m and boot stops after "Loading /bzImage ..... 
Ready", message "Uncompressing Linux" isn't showed. If i unset this option, 
kernel boots fine.
I boot it on dual pentium pro (via pxelinux (netboot)).

lspci
0000:00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
0000:00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 
01)
0000:00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]

0000:00:00.0 0600: 8086:1237 (rev 02)
0000:00:07.0 0601: 8086:7000 (rev 01)
0000:00:07.1 0101: 8086:7010
