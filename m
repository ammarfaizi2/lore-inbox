Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVLaUoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVLaUoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 15:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLaUoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 15:44:09 -0500
Received: from proxy3.nextra.sk ([195.168.1.138]:29454 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S932118AbVLaUoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 15:44:07 -0500
Message-ID: <43B6ED8E.9040205@rainbow-software.org>
Date: Sat, 31 Dec 2005 21:43:58 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.14 on sparc64 - ext3: journal block not found
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've installed Splack 8.0 on Sun Ultra 5, upgraded to 10.1 and compiled 
my own 2.6.14 kernel. It runs but I've got this problem for second time:
-----
journal_bmap: journal block not found at offset 3084 on hda1
Aborting journal on device hda1
ext3_abort called
EXT3-fs error (device hda1): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
-----
hda is standard Seagate 20GB drive that came with the machine, there are 
no HDD errors in logs and the drive just passed SMART long test without 
any errors.
The system was installed on ext2 partition, then after upgrading the 
tools and the kernel, a journal was added using "tune2fs -j".

-- 
Ondrej Zary
