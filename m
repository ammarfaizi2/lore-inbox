Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTCEP7w>; Wed, 5 Mar 2003 10:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbTCEP7w>; Wed, 5 Mar 2003 10:59:52 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:32374 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S267500AbTCEP7v>; Wed, 5 Mar 2003 10:59:51 -0500
Message-ID: <3E6635C5.4080006@myrealbox.com>
Date: Wed, 05 Mar 2003 09:37:09 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre5-ac1:  Broadcom gigabit ethernet quirk introduced
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I have an ASUS A7VX8 motherboard with built-in Broadcom gigabit
ethernet chip which has been working perfectly right up through
-pre4-ac7 and now has developed a strange problem starting with
-pre5-ac1.

After rebooting the machine the Broadcom chip appears to be
configured normally, i.e. 'ifconfig eth0' looks perfectly
normal, and the routing table is the same as always.

The problem is that the chip simply doesn't transmit any packets
until I manually do 'ifconfig eth0 down' and 'ifconfig eth0 up'
at which point the chip starts working normally.

The output of 'ifconfig eth0' is identical before and after this
down/up cycle.  The internal state of the chip is clearly changed
by this manoeuver, however.

Can you think of any change between -pre4-ac7 and -pre5-ac1 which
might have affected the way the Broadcom chip is initialized?


