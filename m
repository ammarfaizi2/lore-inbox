Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265748AbUBKUKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUBKUKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:10:49 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:32989 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265748AbUBKUKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:10:47 -0500
Message-ID: <402A887D.7030408@t-online.de>
Date: Wed, 11 Feb 2004 20:54:37 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2: "-" or "_", thats the question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: bpATviZSoepIRXoxsmzFtvPpdOYEITqfKHmFXDCBBeL-glvKiX9-0g
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

'cat /proc/modules' returns most (all?) of the module names with
"_", e.g.

	:
	ipt_conntrack
	ip_conntrack
	iptable_filter
	ip_tables
	uhci_hcd
	ohci_hcd
	ehci_hcd
	:

Very consistent. But the filenames of some kernel modules are
still written with "-", e.g.

	/lib/modules/2.6.2/kernel/drivers/usb/host/ehci-hcd.ko
	/lib/modules/2.6.2/kernel/drivers/usb/host/ohci-hcd.ko
	/lib/modules/2.6.2/kernel/drivers/usb/host/uhci-hcd.ko

What would be the correct way to get the filename of a
loaded module? The basename would be sufficient.


Regards

Harri
