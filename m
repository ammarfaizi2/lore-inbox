Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbSJANJM>; Tue, 1 Oct 2002 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSJANJM>; Tue, 1 Oct 2002 09:09:12 -0400
Received: from kaneda.oav.net ([195.154.210.144]:14858 "EHLO kaneda.oav.net")
	by vger.kernel.org with ESMTP id <S261618AbSJANJM>;
	Tue, 1 Oct 2002 09:09:12 -0400
User-Agent: CAMAS/1.2.0-FREEZE (CAudium Mail Access System)
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 01 Oct 2002 15:14:39 +0300
Subject: Dead loop on netdevice eth0
MIME-Version: 1.0
From: David Gourdelier <vida@caudium.net>
To: linux-kernel@vger.kernel.org
Message-Id: <20021001131439.6054815673@kaneda.oav.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi list,

I have troubles with an SMP intel Linux acting as a firewall box (with checkpoint ng fp2 modules). I have the following messages and I use dmesg:

Dead loop on netdevice eth1, fix it urgently!
Dead loop on netdevice eth1, fix it urgently!
Dead loop on netdevice eth1, fix it urgently!
Dead loop on netdevice eth0, fix it urgently!

And some packets are dropped without reasons (around 1% of total traffic) while the firewall rules are ok.

Here is the output from uname -a:
Linux firewall 2.4.9-33cpsmp #1 SMP Sun May 19 13:49:25 IDT 2002 i686 unknown

Do you have any hints ?

Thanks :)

-- 
  David Gourdelier

  Caudium webserver, http://caudium.net/
 

