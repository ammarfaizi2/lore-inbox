Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVAaKt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVAaKt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 05:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVAaKt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 05:49:28 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:27091 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261849AbVAaKtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 05:49:25 -0500
Message-ID: <41FE1B4B.2060305@tiscali.de>
Date: Mon, 31 Jan 2005 12:49:31 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: My System doesn't use swap!
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I have mysterious Problem:
90 % of my Ram are used (340 MB), but 0 Byte of my Swap (2GB) is used 
and about about 150 MB are swappable.

[matthias-christian@iceowl ~]$ free
             total       used       free     shared    buffers     cached
Mem:        383868     362176      21692          0         12     208956
-/+ buffers/cache:     153208     230660
Swap:      2097136          0    2097136

[matthias-christian@iceowl ~]$ cat /kernel-2.6.10-rc2-ott/config
[..]
CONFIG_SWAP=y
[..]
CONFIG_X86_BSWAP=y
[..]

[matthias-christian@iceowl ~]$ dmesg
[..]
Adding 2097136k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
[..]

Matthias-Christian Ott


