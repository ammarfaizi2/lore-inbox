Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312799AbSCYWxH>; Mon, 25 Mar 2002 17:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312805AbSCYWw4>; Mon, 25 Mar 2002 17:52:56 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.133]:48818 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S312799AbSCYWwn>; Mon, 25 Mar 2002 17:52:43 -0500
Date: Mon, 25 Mar 2002 17:52:42 -0500
From: Matthew Drobnak <mdrobnak@optonline.net>
Subject: More observations regarding IPv6 on PPC platform.
To: linux-kernel@vger.kernel.org
Message-id: <3C9FAA3A.8000701@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I was attempting to debug a little bit, I installed tcpdump to see 
if it was even seeing the router advertisements...Apparently it was..

On top of that, if you keep tcpdump running, IPv6 works fine!

I noticed that when I had it manually configured, whenever any sort of 
routing was necessary, a neighbor solicitation was sent out, but never 
made it to the other end. However, if I let it auto configure, it worked 
fine, and as well if I added on the secondary addresss using "ifconfig 
eth1 add ....", so, with that being said, is it a MAC or IP address 
filtering problem?

Any ideas would be appreciated, I'd like to get this running, as I'm a 
big fan of IPv6... I have 1 IPv4 address, but a whole /48 to work with. :-D

Thanks again,
-Matthew Drobnak

