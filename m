Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbTCOIUV>; Sat, 15 Mar 2003 03:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTCOIUV>; Sat, 15 Mar 2003 03:20:21 -0500
Received: from smtp4.cbn.net.id ([202.158.3.29]:34268 "EHLO smtp4.cbn.net.id")
	by vger.kernel.org with ESMTP id <S261341AbTCOIUT>;
	Sat, 15 Mar 2003 03:20:19 -0500
Message-ID: <3E72E4CE.1070005@cbn.net.id>
Date: Sat, 15 Mar 2003 15:31:10 +0700
From: Brian Durant <durant@cbn.net.id>
Reply-To: durant@cbn.net.id
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en, da
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Newbie with SiS 900 NIC driver, SuSE 8.1 and Fujitsu-Siemens Celvin
 EasyPC.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please personally CC the answers/comments posted to the list in response 
to my posting, as I am not a list member. I have tried getting the SiS 
900 driver to run on SuSE 7.3, (and now) 8.1, Mandrake 8, 8.1, 9, Debian 
3 rev.1 as well as running the latest Knoppix, none of which has been 
successful. Being a newbie and having only an interest in this one issue 
that I have never been able to resolve, I really don't belong on the 
list either. However, I believe that there is either a bug in the driver 
or my configuration is not supported. Either way, I would like to get 
the issue cleared up.

Anyway, to the issue at hand. There is a Fujitsu-Siemens Celvin EasyPC 
connected to my home WAN/LAN that I have been trying to get to work with 
the SiS 900 driver. The box has a SiS 900 NIC built into a Biostar 
motherboard and uses an Award BIOS. The WAN/LAN consists of 4 computers 
connected to a LinkSys router and a 3 Com cable modem. All other 
computers are able to connect to the Internet through auto DHCP, 
including one that is a dual boot Win2k Pro and SuSE 8.1 box. The Celvin 
is neither able to connect through auto DHCP or with a static IP 
address. I have checked the physical connection using a USB to Ethernet 
adapter and Knoppix, so I know the problem doesn't lie there. The SiS 
900 NIC itself, works fine under Win 98 SE. This seems to me to rule out 
a number of things. Using SuSE 8.1, I have tried:

su
hwinfo --network_ctrl

Included in the info that came back was the following:

Revision: 0 x 01
Driver status: active
Config status: cfg=yes avail=yes need=no

I have found a couple of lines in /var/log/boot.msg that are of 
relevance as well.  With auto DHCP, the message says "DHCP no IP address 
yet... backgrounding". When set to static IP, the boot.msg lists eth0 
with the correct IP address and subnet mask and that is it.

I don't want to confuse the issue as I am using SuSE 8.1 at this time 
however, I think it is also worth noting that with Debian 3 rev. 1 
installed, the output of # /sbin/ifconfig eth0 192.168.1.111 was:

 eth0 Media Link Off.

The result of "$ ping 216.239.57.100" was:

Network is unreachable

I understand if you don't want to help me with my own personal 
configuration problems, but it would be nice to know if there is a bug 
in the driver or if my configuration is unsupported.

Cheers,

Brian Durant




