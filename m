Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbUCUOzd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUCUOzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:55:33 -0500
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:22280 "EHLO
	pc16.dolda2000.com") by vger.kernel.org with ESMTP id S263660AbUCUOz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:55:27 -0500
Message-ID: <405DADAC.9010601@dolda2000.com>
Date: Sun, 21 Mar 2004 09:58:52 -0500
From: Bruce Park <bpark@dolda2000.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI Shutdown 2.6.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear LMKL users,

I'm experiencing a problem with ACPI and it's ability to shutdown the machine. I'm 
currently using Debian GNU/Linux with the 2.6.3 kernel. Before I go on, if this is 
the wrong type of material to post on this list, I apologize in advance. Kindly state 
what I'm doing wrong and I will not make the same mistake.

The following information is about my mobo and BIOS:
Award Modular BIOS v6.0
04/29/2002 - SiS745
ASUS A7S333 ACPI BIOS rv 1006

When I run the shutdown command, the last thing I see is the following:
Power Down
acpi_power_off called
hwsleep_0265 [24] acpi_enter_sleep_state: Entering sleep state [S5]

Here is a result of 'grep -i acpi /var/log/kern.log'. After looking at the output, I 
realized that there was a pattern. I am pasting all the lines that aren't repetitious.
http://www.dolda2000.com/~bpark/kern.log

This is just the output of dmesg:
http://www.dolda2000.com/~bpark/dmesg.txt

I am using the testing release of Debian along with acpid version 1.0.3-2. The funny 
thing is, I have used Fedora Core 1 and even Windows 2000 with ACPI and have been 
able to shutdown the machine without any problems.

Any help is greatly appreciated.

bp

