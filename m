Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUE1M1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUE1M1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUE1MXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:23:34 -0400
Received: from softers.net ([213.139.168.106]:48358 "HELO mail.softers.net")
	by vger.kernel.org with SMTP id S262756AbUE1MUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:20:53 -0400
Message-ID: <40B72EA3.6090106@softers.net>
Date: Fri, 28 May 2004 15:20:51 +0300
From: =?ISO-8859-15?Q?Jarmo_J=E4rvenp=E4=E4?= 
	<Jarmo.Jarvenpaa@softers.net>
Organization: Softers Oy
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange 2.6 booting / freeze problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

I have two servers which share same problem; kernel starts booting and 
freezes to line 'DMI 2.3 present' (thus, almost immediately).

The servers were installed with RH7.3 and RH9 (2.4 kernel) and later, 
were updated(=tested with) to 2.6.3,.4,.5 and .6.

1st server:
After compiling the 2.6 kernel, rebooted, kernel loading -> froze to 
line 'DMI 2.3 present'.
Tried to update to newer kernel(s) but with no success. Changed back to 
2.4.25 -> server ok.


2nd server:
Compiled 2.6.5, rebooted, kernel loaded ok. After release of 2.6.6, 
updated, rebooted, no problems.
Today, I was hoping to test server's raid 1 functionality, rebooted -> 
kernel would not load anymore (lilo and kernel were not touched after 
last update), last line to be seen is 'DMI 2.3 present'.

Updated lilo and bios, no help. Tried to boot with kernel parameters: 
acpi=off noapic nosmp notsc pci=noacpi apic=off, no help.

I had to downgrade to 2.4. :-(
--
The servers share at least one common thing, a i8xx chipset.


Jarmo

