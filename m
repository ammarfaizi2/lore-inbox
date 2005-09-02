Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbVIBUsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbVIBUsD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVIBUsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:48:03 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:29709 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751334AbVIBUsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:48:01 -0400
Message-ID: <4318BA6C.8070707@rainbow-software.org>
Date: Fri, 02 Sep 2005 22:47:40 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: paul@paulbristow.net
Subject: ide-floppy - software eject not working with LS-120 drive
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I've bought "new" LS-120 drive and found that software eject does not 
work with 2.6.13 kernel:
root@pentium:~# eject /dev/hdc
eject: unable to eject, last error: Invalid argument

The drive spins up and after a while the command fails.
This appears in dmesg after each eject attempt:
  hdc: unknown partition table
ide-floppy: hdc: I/O error, pc = 1b, key =  5, asc = 24, ascq =  0

When I boot 2.4.31, eject works fine.

-- 
Ondrej Zary
