Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284935AbRLFCPT>; Wed, 5 Dec 2001 21:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284931AbRLFCPK>; Wed, 5 Dec 2001 21:15:10 -0500
Received: from web20308.mail.yahoo.com ([216.136.226.89]:24586 "HELO
	web20308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S284935AbRLFCOx>; Wed, 5 Dec 2001 21:14:53 -0500
Message-ID: <20011206021449.70021.qmail@web20308.mail.yahoo.com>
Date: Wed, 5 Dec 2001 18:14:49 -0800 (PST)
From: Q A <qarce_mail_lists@yahoo.com>
Subject: Re: ARP shows client is given wrong MAC Address for system with 2 NICs
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org, qarce@yahoo.com
In-Reply-To: <Pine.LNX.3.95.1011205135505.8200A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks, but I am not moving the IP from one to the
other.  I am just saying it doesn't matter _(A) does
not have to be eth0.  Try setting up a system with 2
NICs and follow my notes.  I have checked another
system with a normal 2.4.3 kernel.

Thanks for yours and everyone elses help.

Q


--- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> 
> [SNIPPED...]
> There is an ARP cache, always has been, always will
> be. This is so
> an ARP (Address Resolution Protocol) probe doesn't
> have to occur for
> every data transmission. It is presumed that an IP
> address, including
> your own, won't jump around from device-to-device.
> 
> You are moving your IP address to another device
> (MAC address). What
> do you expect?
> 
> You can delete the old entries from your ARP cache,
> but it has to
> be done for every system that would be affected or
> you can just wait
> for the ARP cache entry to expire.
> 
>     /sbin/arp -d ipaddress
> 
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine
> (799.53 BogoMips).
> 
>     I was going to compile a list of innovations
> that could be
>     attributed to Microsoft. Once I realized that
> Ctrl-Alt-Del
>     was handled in the BIOS, I found that there
> aren't any.
> 
> 


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
