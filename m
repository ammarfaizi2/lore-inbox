Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280992AbRKLVOb>; Mon, 12 Nov 2001 16:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280999AbRKLVOZ>; Mon, 12 Nov 2001 16:14:25 -0500
Received: from okc-65-28-129-177.mmcable.com ([65.28.129.177]:10493 "EHLO
	dogbert.cubicle.home") by vger.kernel.org with ESMTP
	id <S280997AbRKLVOH>; Mon, 12 Nov 2001 16:14:07 -0500
Message-ID: <3BF03AA9.4050205@tux.ou.edu>
Date: Mon, 12 Nov 2001 15:10:01 -0600
From: Robert Cantu <robert@tux.cs.ou.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 pre4: 
	--snip--
 - Andrey Savochkin/Andrew Morton: eepro100 config space save/restore over suspend 
	--snip--

My eepro100 mini-pci card on my laptop currently doesn't handle sleep/suspend very well
for me and needs a reboot to work again. mii-diag output gives wierd data such as
the MAC address set to ff:ff:ff:ff:ff:ff. Looking at the patch code, it seems that 
pci_save_state() and pci_restore_state(), among other things, implements this. 
Will this work with APM's suspend/sleep functions?


