Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbRCCCp7>; Fri, 2 Mar 2001 21:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130236AbRCCCpt>; Fri, 2 Mar 2001 21:45:49 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:12091 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130231AbRCCCpi>; Fri, 2 Mar 2001 21:45:38 -0500
Message-ID: <3AA05A7C.5020109@blue-labs.org>
Date: Fri, 02 Mar 2001 18:44:12 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac3 i686; en-US; 0.9) Gecko/20010302
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Jim Woodward <jim@jim.southcom.com.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 TCP window shrinking
In-Reply-To: <Pine.LNX.4.33.0103030426210.12977-100000@jim.southcom.com.au> <15008.6084.410042.53699@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> We need desperately to know exactly what OS the xxx.xxx.1.14 machine
> is running.  Because you've commented out the first two octets, I
> cannot check this myself using nmap.


I see them all the time on my sites.  I have active mirrors so they 
abound.  Here are a few, I've also attached nmap's guesses.

TCP: peer 148.75.156.238:1025/7000 shrinks window 
3317772066:0:3317772330. Bad, what else can I say?
TCP: peer 195.226.233.21:1774/6660 shrinks window 
2502834461:2920:2502837525. Bad, what else can I say?
TCP: peer 195.39.136.145:1702/7000 shrinks window 
2750401402:2920:2750405782. Bad, what else can I say?
TCP: peer 213.189.87.228:1190/6660 shrinks window 
2933193691:1072:2933194827. Bad, what else can I say?

#1, unknown
#2, running proxy squid/2.3.stable4, can't tell what OS is on it.
#3, unknown
#4, unknown

#2 and #4 both have the following in http headers:

Via: 1.1 netcache (NetCache 4.1R6)

-d

