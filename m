Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUCDXJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUCDXJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:09:16 -0500
Received: from nelson.SEDSystems.ca ([192.107.131.136]:58075 "EHLO
	nelson.sedsystems.ca") by vger.kernel.org with ESMTP
	id S261959AbUCDXJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:09:12 -0500
Message-ID: <4047B706.7070806@sedsystems.ca>
Date: Thu, 04 Mar 2004 17:08:54 -0600
From: Kendrick Hamilton <hamilton@sedsystems.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: SMSC91C111
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    We are using an SMSC91C111 Ethernet chip set on a board we 
developed. The board uses a coldfire 5407 processor and runs the 
uClinux-2.4.x kernel (I have also sent this email to the uClinux 
development list). The driver for the SMSC91C111 is the same for both 
uClinux and Linux.
 When a flood ping the board, the I get the following error:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, IRQ conflict?
Scheduling in interrupt
kernel BUG at sched.c:569!
Kernel panic: BUG!
In interrupt handler - not syncing

Does anybody have a suggestion of what could be going wrong?

I noticed some other people using this chip had problems with interrupts 
from the chip. Has anybody found a work around to these problems. Does 
anybody have a patch to the driver to fix this?

Thank You,
Kendrick Hamilton.

