Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUAYRMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264557AbUAYRMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:12:05 -0500
Received: from mail.aknet.ru ([194.220.14.170]:33544 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S264547AbUAYRMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:12:01 -0500
Message-ID: <4013F8C7.1020105@aknet.ru>
Date: Sun, 25 Jan 2004 20:11:35 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031212
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problems connecting to kernel.bkbits.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I used a BK->CVS gateway on kernel.bkbits.net
for some time, but it is already several
month that I can't connect to it any more.
Is it still alive?

Here is what I have:

$ cvs update
cvs [update aborted]: connect to kernel.bkbits.net(192.132.92.14):2401 
failed: No route to host

$ traceroute kernel.bkbits.net
  1  gate (192.168.3.1)  5.823 ms  16.544 ms  8.973 ms
  2  RINNet-MSU.iitp.ru (194.220.14.45)  12.531 ms  143.000 ms  69.300 ms
  3  RINNet-IITP.iitp.ru (194.220.14.129)  134.844 ms  212.712 ms 
190.928 ms
[.....]
20  svl-edge-09.inet.qwest.net (205.171.14.98)  312.245 ms *  204.768 ms
21  63.150.59.90 (63.150.59.90)  268.390 ms  217.756 ms  218.520 ms
22  216.240.36.206 (216.240.36.206)  218.669 ms  248.692 ms  218.659 ms
23  kernel.bkbits.net (192.132.92.14)  214.393 ms !<10>  243.426 ms 
!<10> *

$ ping kernel.bkbits.net
PING kernel.bkbits.net (192.132.92.14) from 192.168.3.28 : 56(84) 
bytes of data.64 bytes from kernel.bkbits.net (192.132.92.14): 
icmp_seq=0 ttl=44 time=239.295 msec
64 bytes from kernel.bkbits.net (192.132.92.14): icmp_seq=1 ttl=44 
time=230.619 msec

--- kernel.bkbits.net ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max/mdev = 230.619/234.957/239.295/4.338 ms


Now I am lost. ping is fine, but traceroute
shows code 10, which is "Host prohibited".
Any ideas what can that be?
I have googled a lot, but I have found
nothing that looks even nearly similar to the
problem I am having.
