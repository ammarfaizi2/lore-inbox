Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264575AbUAFSIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUAFSIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:08:13 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:62102 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264575AbUAFSIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:08:10 -0500
Message-ID: <3FFAF982.3020004@inp-net.eu.org>
Date: Tue, 06 Jan 2004 19:08:02 +0100
From: Raphael Rigo <raphael.rigo@inp-net.eu.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.1-rc2] SATA problem.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a problem related to Serial ATA : i have an Asus P4P800 Deluxe 
motherboard (ICH5) with 2xCD and 1xSATA HD.
I have the SATA HD working correctly but i can't get the CDs to work. If 
I compile both in the kernel I get :
handlers :
(ide_intr+0x0/0x1b4)
(ata_interrupt+0x0/0x1e8)
that is, both libata and old piix driver try to get access on CDs (as 
Jon Burgess kindly explained to me :)).
If I remove the piix then the system boots correctly.
Any idea on how to fix it ?

Another little thing : the HD activity LED is always on...

Raphaël Rigo.
