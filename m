Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTL2UR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTL2URI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:17:08 -0500
Received: from [62.116.46.196] ([62.116.46.196]:57604 "EHLO it-loops.com")
	by vger.kernel.org with ESMTP id S264126AbTL2UPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:15:04 -0500
Date: Mon, 29 Dec 2003 21:14:59 +0100
From: Michael Guntsche <mike@it-loops.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Network problems with b44 in 2.6.0
Message-Id: <20031229211459.384b2de9.mike@it-loops.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> As soon as I started the process, the following error messages started
> appearing in my syslog.

>	b44: eth0: Link is down.
>	b44: eth0: Link is up at 100 Mbps, full duplex.
>	b44: eth0: Flow control is on for TX and on for RX.
>	b44: eth0: Link is down.

I played around with various settings on my notebook and noticed that
setting the link to 10BaseT-HD gave me a troughput of ~900KB/s.
No error messages in syslog, but ifconfig is still showing lots of errors
and collisions.

eth0      Link encap:Ethernet  HWaddr 00:C0:9F:23:FA:FC  
          inet addr:192.168.0.147  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:89558 errors:21031 dropped:0 overruns:0 frame:21031
          TX packets:65585 errors:0 dropped:0 overruns:0 carrier:26
          collisions:22559 txqueuelen:1000 
          RX bytes:99059807 (94.4 MiB)  TX bytes:3306603 (3.1 MiB)
          Interrupt:5 

I got this after copying 20 MB from the gateway to the notebook.


/Michael
