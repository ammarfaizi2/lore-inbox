Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVB0Snx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVB0Snx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVB0Snx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 13:43:53 -0500
Received: from smtp06.web.de ([217.72.192.224]:65191 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S261251AbVB0Snv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 13:43:51 -0500
Message-ID: <422214D6.2000206@web.de>
Date: Sun, 27 Feb 2005 19:43:34 +0100
From: Torben Viets <Viets@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: XFS dm_crypt BUG?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with the XFS-filesystem, I use the Kernel 2.6.10 and 
2.6.11-rc4 and rc5 everytime the same behavior.

I have a RAID 5(md0) with 3 disks on md0 (chunk-size 128) there is a 
logical volume (/dev/data/mp3-crypt) which is crypted with AES and the 
encrypted version ist under /dev/mapper/mp3, if the filestem on it is 
xfs and then copie some files on it then I get a kernel panic, mostly on 
greater files (>200MB), if I make the same thing with ext3 there is no 
problem. My first thougt was that the problem is that I make a snapshot 
of the device, but if i remove this it won't work anyway.

My sytem is a Pentium4 1800Mhz
512 MB SDRAM

I can't show you the kernel panic message, because I didn't found it in 
the syslog, it is only on the screen,

I'm not sure what infos you need too.

greetings
Torben Viets

