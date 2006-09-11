Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWIKTWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWIKTWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWIKTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:22:51 -0400
Received: from 8.ctyme.com ([69.50.231.8]:53474 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S964977AbWIKTWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:22:50 -0400
Message-ID: <4505B788.1030803@perkel.com>
Date: Mon, 11 Sep 2006 12:22:48 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Segfault Error - what does this mean? 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just put a new server online trying out the new AMD AM2 processor. I compiled a custom kernel because the regular Fedora Core kernels aren't yet compatible with my Asus M2NPV-VM motherboard using the nVidia chipset.

I compiled 2.6.18rc6 and got segfault errors. So I tried the 2.6.17.13 kernel and same thing. About every 20 minutes or so I get one of these.

Sep 11 12:05:18 pascal kernel: exim[19840]: segfault at 0000000000000000 rip 0000003f53e73ee0 rsp 00007fff9e561d18 error 4

At one point the server locked up. Before I put it online I did several days of memory testing with no errors. I believe the Exim code is solid as it has been running flawlessly on all my other servers.

It's probably hardware or some incompatibility but I'm not sure where to start looking. Trying to understand what this error means. What is Error 4? How do I track this down?

Thanks in advance.



