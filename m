Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSCGJfz>; Thu, 7 Mar 2002 04:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310243AbSCGJfp>; Thu, 7 Mar 2002 04:35:45 -0500
Received: from [164.164.94.83] ([164.164.94.83]:64525 "HELO
	mail.india.tejasnetworks.com") by vger.kernel.org with SMTP
	id <S310241AbSCGJff>; Thu, 7 Mar 2002 04:35:35 -0500
Message-ID: <3C873497.27947100@india.tejasnetworks.com>
Date: Thu, 07 Mar 2002 15:06:23 +0530
From: Himanshu Agarwal <himanshu@india.tejasnetworks.com>
Organization: Tejas Networks
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: select() with Network device driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
          I am trying to do a select()  on a net interface.   I need
the poll functionality of a char driver.   That is - I want the select
to block until a certain condition in the driver/hardware becomes
true.   This condition is notified to me by the interrupt handler.

Can somebody point out to how the select() works for sockets.  It goes
to the tcp_select() or udp_select()  in the network subsystem.   However

I want it to go to the net interface.

Pointers to related info would be helpful.

Thanks
Himanshu



