Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbTCMEXL>; Wed, 12 Mar 2003 23:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262161AbTCMEXL>; Wed, 12 Mar 2003 23:23:11 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:50099 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S262158AbTCMEXL>; Wed, 12 Mar 2003 23:23:11 -0500
Message-ID: <3E700A2F.7050103@lemur.sytes.net>
Date: Wed, 12 Mar 2003 23:33:51 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, zh-tw
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA EPIA-M1000 AGP device ID
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop015.verizon.net from [68.162.36.8] at Wed, 12 Mar 2003 22:33:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like the onboard CLE266 chip is not yet recognized
by the kernel:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 381M
agpgart: Unsupported Via chipset (device id: 3123), you might want to 
try agp_try_unsupported=1.
agpgart: no supported devices found.

lspcidrake says:

unknown         : unknown (1106/3123/1106/aa01) [BRIDGE_HOST]
unknown         : unknown (1106/3122/ffff/ffff) [DISPLAY_VGA]

