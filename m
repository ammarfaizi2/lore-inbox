Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRK2S6Z>; Thu, 29 Nov 2001 13:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280320AbRK2S6Q>; Thu, 29 Nov 2001 13:58:16 -0500
Received: from mail.london-1.starlabs.net ([212.125.75.12]:24328 "HELO
	mail.london-1.starlabs.net") by vger.kernel.org with SMTP
	id <S279113AbRK2S6H>; Thu, 29 Nov 2001 13:58:07 -0500
X-VirusChecked: Checked
Date: Thu, 29 Nov 2001 18:57:01 +0000 (GMT)
From: Catalin Marinas <c_marinas@yahoo.com>
X-X-Sender: marinasc@stargate.simoco.com
To: Rajasekhar Inguva <irajasek@in.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Routing table problems
In-Reply-To: <OF8DFA00F6.3DAC22D2-ON65256B31.003CB38A@in.ibm.com>
Message-ID: <Pine.LNX.4.40.0111291846140.26769-100000@stargate.simoco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Rajasekhar Inguva wrote:

> 4) ifconfig eth0 up
>
> After the the 4'th command, my interface is up and has it's IP address set
> correctly. But .....
>
> netstat -nr  does not show my default gateway for network 0.0.0.0 !!.

ifconfig just brings the interface up, it does not set the routes. It is
not a kernel problem.

Usually, an interface is brought up by the /sbin/ifup (or
/etc/sysconfig/network-scripts/ifup) script which calls ifconfig and then
adds the default route by calling /sbin/route.

-- 
Catalin


_____________________________________________________________________
This message has been checked for all known viruses by the 
MessageLabs Virus Scanning Service. For further information visit
http://www.messagelabs.com/stats.asp

