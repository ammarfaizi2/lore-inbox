Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266651AbUAWVnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 16:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUAWVnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 16:43:11 -0500
Received: from relay.inway.cz ([212.24.128.3]:1686 "EHLO relay.inway.cz")
	by vger.kernel.org with ESMTP id S266651AbUAWVnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 16:43:08 -0500
Message-ID: <40119572.5020403@scssoft.com>
Date: Fri, 23 Jan 2004 22:43:14 +0100
From: Petr Sebor <petr@scssoft.com>
Organization: SCS Software
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.x] e1000: NETDEV WATCHDOG: eth0: transmit timed out
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since we have upgraded cabling on our network and transfer speeds 
increased a little
bit, we are experiencing very often situations where the Intel PRO/1000 
nics just stop
responding and network dies for a while. Local console works, there are 
no more error
messages other than (when the eth0 comes to a life again):

NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex

then its working ok again, until the next watchdog message.

It has happened even before the cabling upgrade, it was just very rare.

I have tried kernels 2.6.0, 2.6.1, 2.6.2-bk1 and it happens all the
time. It is just that is _seems_ to happen more often with the 2.6.2-bk

The machine in question is an Opteron 244 based server (though kernel
is compiled for 32bits/Athlon). SMP kernel makes no difference, it will
eventually happen as well. The server is not heavily loaded... only few 
users
can trigger the issue. Board is MSI KT800 based.

I have tried to switch NICs, but there is no difference. Onboard 
integrated TG3
gigabit network controller suffers the '100% CPU usage' issue when 
utilized so
this unfortunately no option at the moment.

Anyone having a clue what might be wrong here?

Have a nice weekend,
Petr

