Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTEJXlA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 19:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTEJXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 19:41:00 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:3018 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S264527AbTEJXk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 19:40:59 -0400
Message-ID: <3EBD90F7.6040306@blue-labs.org>
Date: Sat, 10 May 2003 19:53:27 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI and battery information, 2.5.69
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Not 2.5.69 specific -- waiting for it to be implemented)

(/proc/acpi/battery/BAT0) # cat info
present:                 yes
design capacity:         0 mWh
last full capacity:      0 mWh
battery technology:      non-rechargeable
design voltage:          0 mV
design capacity warning: 0 mWh
design capacity low:     0 mWh
capacity granularity 1:  0 mWh
capacity granularity 2:  0 mWh
model number:           
serial number:          
battery type:           
OEM info:               

(/proc/acpi/battery/BAT0) # cat state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      0 mAh
present voltage:         0 mV


According to http://jpstrand.homeip.net/user/delli8200/delli8200.html, 
ACPI patch 20030328 produces full battery information for 2.4.21-preX 
kernels.

David

