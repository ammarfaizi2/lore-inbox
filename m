Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbTCRTcP>; Tue, 18 Mar 2003 14:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262559AbTCRTcP>; Tue, 18 Mar 2003 14:32:15 -0500
Received: from freeside.toyota.com ([63.87.74.7]:56205 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S262558AbTCRTcO>; Tue, 18 Mar 2003 14:32:14 -0500
Message-ID: <3E7776C9.4040201@tmsusa.com>
Date: Tue, 18 Mar 2003 11:43:05 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm8 breaks MASQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn wrote:

>This actually broke in -mm7, but I don't know what causes it.
>
>I have to admit, I haven't even looked at the patch to see what changed.
>Oh well, I suspect good ol' 65-mm1 will fix things up. If so, my TiVo
>could stop holding it's breath. ;)
>
>Anyone else seeing this?
>  
>

I'm seeing a weird problem with later 2.5.64-mm,
probably related - when the problem hits, I have
to "make things work" quickly, so there is not a
lot of time to analyze (booting back into the 
latest -ac kernel makes everyone happy)

The box in question, running RH 8.0, is set up
as a dhcp server, iptables firewall, and squid
proxy for a small network of 6 systems (3 linux,
3 ms windows)

After booting up, it all works initially, but after
some time, the windows/dhcp users complain
that they can't get out to the internet anymore.

Very odd, since my internet access via a linux
workstation seems fine - I could just say "wow,
it sure sucks to be a win doze user" and move
on, but I can't quite get away with that...

So the problem is rather interesting, and multi-
faceted - I'm not sure at this point whether the
problems follow the ms windows users, or the
dhcp users, or those not plugged into the same
switch that's in my office... but I'm willing to 
try possible fixes through a brute force trial
and error approach.

Joe






