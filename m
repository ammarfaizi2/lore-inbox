Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLTG1Z>; Wed, 20 Dec 2000 01:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLTG1P>; Wed, 20 Dec 2000 01:27:15 -0500
Received: from web4605.mail.yahoo.com ([216.115.105.160]:29971 "HELO
	web4605.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129391AbQLTG1E>; Wed, 20 Dec 2000 01:27:04 -0500
Message-ID: <20001220055636.7325.qmail@web4605.mail.yahoo.com>
Date: Tue, 19 Dec 2000 21:56:36 -0800 (PST)
From: TongEng Chiah <techiah@yahoo.com>
Subject: TCP/IP kernel modification
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 
  currently i'm experimenting with some routing
protocols. I need to modify the action taken by the  
kernel after it fails to find a matching route in the
routing cache and the FIB.

i.e after the kernel calls ip_route_output() and
ip_route_output_slow() and fails to find a match, i
need the kernel to somehow "hook-up" with a
process/daemon(routing protocol) and access a user
route cache there.

how can i go about doing this?

thanks 



__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
