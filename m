Return-Path: <linux-kernel-owner+w=401wt.eu-S1754244AbWLRQgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbWLRQgk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 11:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbWLRQgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 11:36:39 -0500
Received: from apollo.i-cable.com ([203.83.115.103]:60403 "HELO
	apollo.i-cable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754244AbWLRQgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 11:36:38 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 11:36:38 EST
Message-ID: <002601c722c1$9c4d1b80$28df0f3d@kylecea1512a3f>
From: "kyle" <kylewong@southa.com>
To: <linux-kernel@vger.kernel.org>
Subject: schedule_timeout: wrong timeout value
Date: Tue, 19 Dec 2006 00:28:53 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently my mysql servershows something like:
Dec 18 18:24:05 sql kernel: schedule_timeout: wrong timeout value ffffffff 
from c0284efd
Dec 18 18:24:36 sql last message repeated 19939 times
Dec 18 18:25:37 sql last message repeated 33392 times

from syslog every 1 or 2 days. Whenever the messages show, mysql server stop 
accept new connections from the same network, and I need to restart the 
mysql service and then it will keep running well for 1-2 days until the 
messages show up again.

The server has been running over 1 year without any problem, the problem 
started show up around 2 weeks ago. It's running kernel 2.6.12, and mysql 
server, nothing else. Hardware is Pentium 4 2.8GHz with hyperthreading 
enabled.

What does the kernel message mean and why it make mysql stop accept new 
connections? Is it hardware problem or try upgrade the kernel may help?
Please CC me if possible. Thank you

Kyle



