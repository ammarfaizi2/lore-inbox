Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTIPPH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTIPPHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:07:55 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:12693 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S261909AbTIPPHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:07:16 -0400
Message-ID: <3F6726EF.7090906@blue-labs.org>
Date: Tue, 16 Sep 2003 11:06:23 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030912
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ip/ifconfig down/up hangs network, 2.6.0-test5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eth2: Station identity 001f:0001:0008:000a
eth2: Looks like a Lucent/Agere firmware version 8.10
eth2: Ad-hoc demo mode supported
eth2: IEEE standard IBSS ad-hoc mode supported
eth2: WEP supported, 104-bit key
eth2: MAC address 00:02:2D:5C:18:9F
eth2: Station name "HERMES I"
eth2: ready
eth2: index 0x01: Vcc 3.3, irq 9, io 0x0100-0x013f
eth2: New link status: Connected (0001)
spurious 8259A interrupt: IRQ7.
eth2: New link status: Connected (0001)

If I set this network card down and try to bring it back up, all net 
device access stalls in D state.  No dmesg, no panics, nadda.

David


