Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVATWFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVATWFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVATWEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:04:54 -0500
Received: from imap.gmx.net ([213.165.64.20]:64459 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262106AbVATWCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:02:22 -0500
X-Authenticated: #1425685
Date: Thu, 20 Jan 2005 22:57:48 +0100
From: Sebastian <Ostdeutschland@gmx.de>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1 problem with battery state (AE_ALREADY_EXISTS)
Message-Id: <20050120225748.2d1a7cfc.Ostdeutschland@gmx.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i reported this error some time ago, without any reply...
i'm running 2.6.11-rc1 now on an acer travelmate 291lci laptop.

[admin@laptop]$ while [ 1 ]; do cat /proc/acpi/battery/BAT1/state &&
sleep 1; done
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16647 mV
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16645 mV
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16645 mV
 dswload-0294: *** Error: Looking up [PBST] in namespace,
AE_ALREADY_EXISTS
 psparse-0601 [915] ps_parse_loop         : During name lookup/catalog,
AE_ALREADY_EXISTS
 psparse-1138: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BST] (Node defc21e8), AE_ALREADY_EXISTS
acpi_battery-0208 [908] acpi_battery_get_statu: Error evaluating _BST
present:                 yes     
ERROR: Unable to read battery status
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16647 mV
     osl-0958 [992] os_wait_semaphore     : Failed to acquire
semaphore[c172c5a0|1|0], AE_TIME 
present:                 yes     
capacity state:          ok      
charging state:          charged 
present rate:            0 mA    
remaining capacity:      4000 mAh
present voltage:         16647 mV



thanks, sebastian
