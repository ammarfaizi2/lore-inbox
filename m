Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSHFVlt>; Tue, 6 Aug 2002 17:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSHFVlt>; Tue, 6 Aug 2002 17:41:49 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:18854 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S315709AbSHFVlt>;
	Tue, 6 Aug 2002 17:41:49 -0400
Message-ID: <3D5045C1.6050302@zianet.com>
Date: Tue, 06 Aug 2002 15:55:13 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020802
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davem@redhat.com, jgarzik@mandrakesoft.com
Subject: Tigon3 and jumbo frames
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the new version of the tigon 3 (tg3) drivers support jumbo
frames?  I have 2.4.19 using the v0.99 driver and I can't for the life
of me get the card to work with the jumbo frames.  I have a switch
that supports jumbo frames and I also have like 3-4 other computers
attached to the switch that are using the e1000 drivers.  Between
the comps with the e1000 drivers I can transmit/receive jumbo
frames fine, but when I try to send/receive jumbo frames from the
computer with the tg3 to any computer with the e1000 drivers it fails.  
I can transmit/receive normal sized (1500 MTU) sized frames fine
with the tg3 however. All the NICS have the MTU size set to 9000
and I initiate the jumbo frames by 'ping -s 9000 192.168.1.1'.
By glancing at the code I can see defines for the jumbo frames at it
is defined to 9000.  I noticed in the changelog for 2.4.19 that there
were quite a few changes to this driver and I am just wondering
if somethin was possibly broken in the process.

