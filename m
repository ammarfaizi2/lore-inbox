Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUGFMaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUGFMaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 08:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUGFMaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 08:30:10 -0400
Received: from news.ti.com ([192.94.94.33]:6622 "EHLO dragon.ti.com")
	by vger.kernel.org with ESMTP id S263815AbUGFMaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 08:30:02 -0400
Message-ID: <40EA9B31.3000404@ti.com>
Date: Tue, 06 Jul 2004 15:29:37 +0300
From: Alexander Sirotkin <demiurg@ti.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cardbus/pci question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2004 12:29:43.0262 (UTC) FILETIME=[EA4E4FE0:01C46354]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could not find any information on this in the archives, so I thought I 
might ask it here.

Theoretically, it should be possible to write cardbus driver as a 
regular PCI driver. It will
not support hotplug, of course, but if one can assume that the hardware 
is plugged in by the
time the driver is loaded, it should work. One issue does bother me a 
little bit - cardbus is
connected to the PCI bus through a bridge. The question is - do I have 
to configure that bridge
from my driver (to get memory mappings and interrupts), because 
obviously the OS won't
do it for me when I'm not registered as cardbus driver.

Thanks.

In your answer, please CC me since I'm not subscribed to the list.

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 


