Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWGMH6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWGMH6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWGMH6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:58:04 -0400
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:64469 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S964848AbWGMH6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:58:02 -0400
Message-ID: <44B5FCEC.8040903@rrz.uni-koeln.de>
Date: Thu, 13 Jul 2006 09:57:32 +0200
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.SL3 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ACPI: SBS in linux-2.6.18-rc1 - Works for me!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've tested linux-2.6.18-rc1 with Smart Battery System enabled. It works 
for my Acer Extensa 3002 WLMi. No compile errors or bugs at first sight.

Perhaps there should be some logic in the configuration to disable the 
ac and battery modules. They are not needed if SBS is active.

Is it possible to load sbs and i2c-ec automatically together with the 
other ACPI modules? On my Debian system I had to load the modules via 
/etc/modules.conf.


Regards,
Berthold
