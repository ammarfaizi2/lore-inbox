Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbULGAHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbULGAHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULGAHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:07:38 -0500
Received: from cs.columbia.edu ([128.59.16.20]:25476 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S261708AbULGAHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:07:33 -0500
Message-ID: <41B4F445.6040403@cs.columbia.edu>
Date: Mon, 06 Dec 2004 19:07:33 -0500
From: Andrea G Forte <andreaf@cs.columbia.edu>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IP aliasing and IP change delay.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621, Antispam-Engine: 2.0.2.0, Antispam-Data: 2004.12.6.29
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am new to this list but I hope you can help me.
I have been trying to use two different IP addresses on the same PCMCIA 
wireless card. For doing this I tried the classic
ifconfig wlan0:0 inet xxx.xxx.xxx.xxx
route ......
and I also tried
ip address add xxx.xxx.xxx.xxx dev wlan0

The problem is that after I issue the command, the IP is actually 
changed several hundred of milliseconds later, while if I do not create 
an alias and change the IP twice on the same interface (using ifconfig), 
then the change of IP is really fast, practically it changes starting 
from the packet following the command.
Anybody has some ideas why there is such a double behaviour if using 
wlan0 and wlan0:0 or using only wlan0??

Thank you very much for your help,
Andre
