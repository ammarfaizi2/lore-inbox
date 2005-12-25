Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVLYEG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVLYEG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 23:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVLYEG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 23:06:59 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:17062 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750773AbVLYEG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 23:06:58 -0500
Message-ID: <43AE1AD6.1030300@comcast.net>
Date: Sat, 24 Dec 2005 23:06:46 -0500
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Thompson <norsk5@yahoo.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine check 2.6.13.3 dual opteron
References: <20051224194621.73206.qmail@web50113.mail.yahoo.com>
In-Reply-To: <20051224194621.73206.qmail@web50113.mail.yahoo.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Doug Thompson wrote:
> With the Opteron Bank 4 value you gave, this decodes to:
> 
> 
> Decoding MCE value as MCi_STATUS: 'b200000000070f0f'
> Bit  63:    Valid error
> Bit  61:    UNCORRECTED error
> Bit  60:    MCA Error Reporting Enabled
> Bit  57:    Process Context Corrupt
>             HyperTransport Link Number= 0
>             Extended Error Code = 0x7 - WatchDog error
> 
> BUS Error:
>         Processor(generic)
>         TimeOut(timed out)
>         Memory Transaction Type(generic)
>         Mem or IO(generic)
>         Cache Level(generic)
> 
> You had an Uncorrectable Error. 
> Since you did not post an address error, I assume that it did NOT report such. Therefore, because
> of the WatchDog error, there might be an error between the CPU and memory.  There is a hardware
> problem definitely.
> 
> CPU-Mem Controller
> Even bad memory DIMM
> 
> doug thompson

HI Doug,

Thank you for your quick reply.  There was no "address error" - the only
 thing on the serial console is what I posted.

In the past, this board, the CPUs, and these memory DIMMs have passed 24
continuous hours of memtest, but perhaps something has deteriorated in
the mean time.  I'll run memtest again to see if I can find a problem.

FYI:  This MB (MSI K8T Master2 FAR) has been problematic since day one.
 A BIOS upgrade improved stability, but I've never gotten more then 21
straight days of uptime on this machine (compared to 200-300 days on
several other machines in my house).  I've had *many* random hangs but
seldom does something get printed on the serial console.  When it does
hang, the serial console is unresponsive.

I'll be swapping out this MB in favor of a Tyan.  I've put up with it
long enough.  Assuming that the Tyan MB solves the problem, I won't be
purchasing any more MSI MBs (and neither will my friends if I have
anything to say about it).

Thanks again for the help!

Andy

- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDrhrVHl0iXDssISsRAhzLAJoCb5yTL2meARSIVhnQjP54AVVPOwCeJ2aS
NWkOTzLQ57U6tuU8h+YM9bM=
=NH89
-----END PGP SIGNATURE-----
