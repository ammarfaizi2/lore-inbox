Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288796AbSAELto>; Sat, 5 Jan 2002 06:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288781AbSAELtf>; Sat, 5 Jan 2002 06:49:35 -0500
Received: from smtp02.web.de ([217.72.192.151]:12579 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S288796AbSAELtY>;
	Sat, 5 Jan 2002 06:49:24 -0500
Message-ID: <3C36E715.9030303@web.de>
Date: Sat, 05 Jan 2002 12:44:21 +0100
From: Klaus Zerwes <kzerwes@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug ?
In-Reply-To: <3C30A9F0.3070603@web.de> <20011231195115.410b871f.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

> On Mon, 31 Dec 2001 19:09:52 +0100
> Klaus Zerwes <kzerwes@web.de> wrote:
> 
> 
>>My PC hangs sporadicaly (every 2 weeks) after heavy Network traffic.
>>I tried to work around the problem by changing the NIC (dmfe > 
>>realtek, using new driver 8139too), but it din't help.
>>
> 
> Hm, I think I saw something the like. The configuration was basically SuSE 7.3
> (with 2.4.10-whatever kernel) and two Realtek cards in a not-trusted cheap box.
> I saw a good amount of collisions on the network, too. I replaced the Realteks
> with DLink and the kernel with 2.4.16 and it did not happen again, although the
> network collisions stayed the same. I tend to think it is the old kernel, but I
> don't like Realtek cards anyway, so I threw them out in one go.
> 
> Tell us if it happens again with 2.4.17, or if you are sure it does not,
> declare it as solved.
> 
> Regards,
> Stephan
> 


I have copmpiles 2.4.16 and did some tests with a mirrored system ( 
only the system, without the harddisks with data) using different 
NICs: Davicom FE (dmfe), RT 8139C (8139too) and SMC 9432 EtherPower II 
  83c172 (epic100).
The System did work fine (the Realtek-NIC I had a huge amount of 
collisions, but it did work!, with the SMC-NIC the Tx-speed was not 
hipeak, but it did work werry constant).
I testet nearly every protocol I can handle and created a realy hard 
networktraffic for a nearly a complete day and the system did not crash!!
Hopefully I was setting my configuration up, connected the 
data-harddisks and rebooted - id did not take 30 minutes and the 
system crashed again. My knowledge of systems is not the best, but for 
me this seems to be a hardwareproblem with the board. From a 
retrospektiv point of view: this box did work for nearly 3 years under 
Linux (suse, debian, slackware) and with FreeBSD and it worked fine - 
but only with one harddisk.
I know that this ALI-board is not the best, but I did not know it is 
realy so bad.

-- 
live free or die :: linux

