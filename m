Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVL2UwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVL2UwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVL2UwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:52:20 -0500
Received: from butters.phys.uwm.edu ([129.89.61.125]:59624 "EHLO
	butters.phys.uwm.edu") by vger.kernel.org with ESMTP
	id S1750967AbVL2UwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:52:19 -0500
Date: Thu, 29 Dec 2005 14:52:16 -0600 (CST)
From: Paul Armor <parmor@gravity.phys.uwm.edu>
X-X-Sender: parmor@butters.phys.uwm.edu
To: linux-kernel@vger.kernel.org
cc: Paul Armor <parmor@gravity.phys.uwm.edu>
Subject: Enabling TSO on BCM 5704, with tg3
Message-ID: <Pine.LNX.4.63.0512291440020.32757@butters.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've noticed something strange regarding enabling TSO (or the inability to 
do so) on a Supermicro H8SSL-i using the tg3 driver on a Broadcom 5704, 
and I was wondering if anyone could provide any info or insights as to 
whats wrong.  Please cc me with responses as I'm not currently subscribed 
to the list.

The machine has two 5704's (reported by the driver as: "Tigon3 
[partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:133MHz:64-bit)..." onboard.
One can be shared with a BMC (for IPMI) and I tested with the BMC 
installed and not installed.  The interface that does NOT share 
connectivity can have TSO enabled, and the interface that shares cannot 
have TSO enabled.

Is anyone aware of a reason that we should not be able to enable TSO on 
that interface?


The particulars:
 	Supermicro H8SSL-i
 	OS=Fedora Core 4
 	kernel = stock kernel-smp-2.6.11-1.1369_FC4.x86_64
 	interface reported as "partno(BCM95704A6) rev 2100 PHY(5704)"

Thanks in advance for your help!

Cheers,
Paul

