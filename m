Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbSKSPYm>; Tue, 19 Nov 2002 10:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266717AbSKSPYm>; Tue, 19 Nov 2002 10:24:42 -0500
Received: from web40605.mail.yahoo.com ([66.218.78.142]:40514 "HELO
	web40605.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266645AbSKSPYl>; Tue, 19 Nov 2002 10:24:41 -0500
Message-ID: <20021119153140.78651.qmail@web40605.mail.yahoo.com>
Date: Tue, 19 Nov 2002 07:31:40 -0800 (PST)
From: Pratik Bose <bosep@yahoo.com>
Subject: Kernel seems to be dropping raw eth1 packets
To: linux-kernel@vger.kernel.org
Cc: bosep@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a tiny test application which is sending
packets on two ethernet interfaces eth0 and eth1, by
supplying IP_PKTINFO in the sendmsg program. However,
while the same code works for eth0 and lo, the eth1
packets are never sent, and sendmsg never gives me an
error. Seems like the kernel drops those packets
silently.  

I have tried a SO_BINDTODEVICE on the raw socket, and
also passed the index of the interface after I
retrieve it using ioctl on an ifreq structure. Neither
of them have succeeded. 

Kindly cc me to the reply, since I am not subscribed
to the mailing list. 

Thanks and Regards

Pratik

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - Let the expert host your site
http://webhosting.yahoo.com
