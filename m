Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVHQVeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVHQVeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVHQVeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:34:07 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:27763 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbVHQVeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:34:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J/J3KE/Mlz+mAr02Gc/xAuBpBC4oeV0gUoSKx8FySNKbSw/LW7FwsPawVEFJMyTB/ZMJGMj4OFvNNJaeFZmzKdNPZ5YM0KsxgP8mHaMYiriyr8+94CRUlvoq44875AvHYvM+fdN66ecdqxaOQXn9xgf/+O7prLvG7lT+7azyfQ4=
Message-ID: <3aa654a405081714343073a621@mail.gmail.com>
Date: Wed, 17 Aug 2005 14:34:04 -0700
From: Avuton Olrich <avuton@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: help! forcedeth network errors and packet drops - Was: ACPI Standby and nvidia ethernet driver causes network errors and drops
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reference (was):
http://marc.theaimsgroup.com/?l=linux-kernel&m=112421051105982&w=2

Corrections:
1) It is not the 'nvidia' driver, it is the 'forcedeth' ethernet driver
2) It does _not_ only happen after standby, I have finally experienced
errors and drops without going into standby.

Now, with this said is there anything I can enable in the kernel to
help diagnose the issue. I am currently using 2.6.12-rc5-mm1 on this
computer. I have read that this could be caused by being at the wrong
duplex, which as far as I could tell should be full (that's what all
the other computers on the network seem to be at) but I cannot find
that information nowhere in the /proc at least. I have also changed
the network cable 3 times, which I have also read could have been the
problem.

Also here's some netstat information:
netstat -i:
Kernel Interface table
Iface     MTU Met   RX-OK RX-ERR RX-DRP RX-OVR   TX-OK TX-ERR TX-DRP TX-OVR Flg
eth0       1500   0   14503      0      0      0   17207    809      0
     0 BMNRU
lo        16436   0     260      0      0      0     260      0      0
     0 LRU

I have included everything I can think of between these two emails,
feel free to ask for more, or please help.

thanks,
avuton
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
