Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTIYUS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 16:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTIYUS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 16:18:57 -0400
Received: from zeke.inet.com ([199.171.211.198]:56238 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S261874AbTIYUSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 16:18:54 -0400
Message-ID: <3F734DAA.5040307@inet.com>
Date: Thu, 25 Sep 2003 15:18:50 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adarsh Daheriya <AdarshDNet@netscape.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: dual ethernet ports problem.
References: <3F71B513.1000204@netscape.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adarsh Daheriya wrote:
> hi all,
> 
> i have got a system which has 2 eth ports. i use one of them (eth0) to 
> "network boot" the system
> using dhcp, tftp and then mount the nfs file system on it.
> 
> this leaves the other port (eth1) unusable. i cannot ping to the other 
> system through it.
> but when i ping any of the two eth ports from some other system i get 
> the reply back.
> but to my amazement the mac entries of both the ports is that of eth0 in 
> arp table. (arp command)
> 
> why and how eth0 is acting as a proxy (perhaps) for both the ports and 
> how can i disable it?
> 
> could anybody please help me in this concern.

Both ports on the same subnet/switch/etc perchance?

Linux replies to an IP address out of any port it cares to.[1]  I've 
seen this come up a number of times, but I can't seem to find references 
to it in google.... Ah, wait, try this:
http://www.cs.helsinki.fi/linux/linux-kernel/2002-16/0676.html
LWN writeup about this: http://lwn.net/Articles/45373/
(Google for 'linux-kernel ping route IP MAC wrong' w/o quotes.)

HTH,

Eli

[1] Over-simplification to the extreme, and probably wrong to boot. 8)
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

