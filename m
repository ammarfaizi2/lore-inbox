Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVDBNJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVDBNJC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 08:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVDBNJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 08:09:02 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:62174 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261406AbVDBNJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 08:09:00 -0500
Message-ID: <424E9965.2010303@tiscali.de>
Date: Sat, 02 Apr 2005 15:08:53 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: some questions towards the boot sequence
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm currently developing a small OS. But I have some questions towards 
the boot sequence:
Grub (0.9.6) is installed in the MBR of the Harddisk (512 Byte - Stage 
1) than grub loads Stage 2 which is located at a fixed address 
(specified in stage1.h), but how is this location linked to an inode and 
marked as used (e.g. in the ext2/3 bitmap)? And doesn't it conflict with 
the file system? And how can I instruct grub to load a file from a not 
specified location which is maybe splited without updating it every time 
the location changes?
Maybe there are some documents which include the answers to my questions 
and some additional information.

Thanks
Matthias-Christian Ott
