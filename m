Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUHUFrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUHUFrf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 01:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268853AbUHUFre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 01:47:34 -0400
Received: from web41408.mail.yahoo.com ([66.218.93.74]:44709 "HELO
	web41408.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268851AbUHUFrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 01:47:33 -0400
Message-ID: <20040821054732.28472.qmail@web41408.mail.yahoo.com>
Date: Fri, 20 Aug 2004 22:47:32 -0700 (PDT)
From: cranium2003 <cranium2003@yahoo.com>
Subject: modifying tcp/ip stack
To: netfilter <netfilter-devel@lists.netfilter.org>
Cc: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
        I want to modify existing protocol stack as
given below.
        What exactly i want to do is that i want to
add a new protocol headerin between IP and ETHERNET
header.
        I want to implement packet structure as
(Ethernet header +MY header + IP header +TCP header +
PAYLOAD) that mean when packet comes from NIC it
should first remove MY header in my routine then IP
header in ip_input.c file.
        Also at transmitting end packet at IP layer
with (IP header + TCP header +PAYLOAD)structure passed
to ip_output.c then given to my routine for adding a
new protocol header on that packetand then to Ethernet
layer.
        I want your help to know what changes i
require to do in kernel 2.4.24 to achieve this?
         Please kindly reply me.
Thaking you.

Regards,
Parag.


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
