Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTDPJHY (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTDPJHY 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:07:24 -0400
Received: from nontri.ku.ac.th ([158.108.2.71]:60822 "EHLO ku.ac.th")
	by vger.kernel.org with ESMTP id S262788AbTDPJHX 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 05:07:23 -0400
Message-ID: <00e701c303f9$3bbc92e0$35226c9e@cpe.ku.ac.th>
From: "Theewara Vorakosit" <g4465018@cc.cpe.ku.ac.th>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Invalid IOctl
Date: Wed, 16 Apr 2003 16:19:06 +0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
    I'm sorry it you get more than one copy of this mail.

    I user Gigabyte 7VXRP mainboard. It has on board promise ATA 
Raid/ATA 133 controller. I set in BIOS to user Raid. The chip model 
reported from lspci is PDC20276.

00:0f.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)

    I configure raid 0 on it with 2 80G-HDD. I use red hat 9. I install 
it on 40 G hdd (hda). The kernel version is 2.4.20-9. I manually insert 
ataraid and pdcraid module. Then I can create 160G on it everything is 
OK. However, when I mount partition on it, there is an error message: 
"Invalid ioctl". Why this error message is displayed? Does it effect to 
system stability?
    Before I install redhat 9, I used this system with redhat 7.3 and 
driver from promise. During install, it said that I have to initialize 
raid. So, my data is lost. If I upgrade kernel (using redhat rpm), is 
there any chance that my data will lost?

Thanks,
Theewara
