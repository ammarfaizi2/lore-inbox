Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRE0C1d>; Sat, 26 May 2001 22:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbRE0C1X>; Sat, 26 May 2001 22:27:23 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55247 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262715AbRE0C1P>;
	Sat, 26 May 2001 22:27:15 -0400
Message-ID: <3B1065FD.3F8D7EDF@mandrakesoft.com>
Date: Sat, 26 May 2001 22:27:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: cesar.da.silva@cyberdude.com
Cc: kernellist <linux-kernel@vger.kernel.org>
Subject: Re: Please help me fill in the blanks.
In-Reply-To: <20010527021808.80979.qmail@web13407.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cesar Da Silva wrote:
> The features that I'm wondering about are:
> * Dynamic Processor Resilience

is this fault tolerance?  I think if a CPU croaks, you are dead.

There are patches for hot swap cpu support, but I haven't seen any CPU
fault tolerance patches that can handle a dead processor

> * Dynamic Memory Resilience

RAM fault tolerance?  There was a patch a long time ago which detected
bad ram, and would mark those memory clusters as unuseable at boot. 
However that is clearly not dynamic.

If your memory croaks, your kernel will experience random corruptions

> * Dynamic Page Sizing

no

> * Live Upgrade

LOBOS will let one Linux kernel boot another, but that requires a boot
step, so it is not a live upgrade.  so, no, afaik

> * Alternative I/O Pathing

be less vague

> * HSM

patches exist, I believe

> * TCP selective acknowledgement (SACK)

yes

> * Service Location Protocol (SLP)

don't know

> * ATM IP switching

yes, I believe

> * SOCKS 5 support

yes, via userspace apps/libs

> * Multilink PPP

yes

> * TCP/IP Gratuitous ARP (RFC 2002)

not sure

> * Path MTU Discovery (RFC 1191)

yes

> * Path MTU Discovery over UDP

not sure, but I think so

> * IP Multipath Routing

yes

> The questions I have about the features above are:
> * Are any of the above features implemented in the
> kernel? If yes, where can I read (url-link  to the
> article, paper... please) about it?

http://google.com/

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
