Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHx6eg05fEOES5emS0/ghzZd7w==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 14:14:43 +0000
Message-ID: <020501c415a4$7c7ad0e0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:42:48 +0100
From: "Thomas Molina" <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: <Administrator@smtp.paston.co.uk>
Cc: "Andrew Morton" <akpm@osdl.org>
Subject: debug messages in 2.6.1-rc1-mm1
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:51.0921 (UTC) FILETIME=[7ECA1810:01C415A4]

I'm getting the following on my laptop while it is just sitting doing 
nothing.  The connect/disconnect lines are from my wireless pcmcia card.  
I'm not sure why I get so many of these messages.  My laptop is sitting 
within five feet of the WAP, so there should'nt be any of these messages.  
Also, they always used to go to /var/log/messages when they did happen.  I 
have no idea where the debug message came from.

eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
 00 00 <8b> 80 88 00 00 00 89 45 c0 b8 00 e0 ff ff 21 e0 ff 48 14 8b 40
 <6>note: pidof[1819] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0125d8b>] __might_sleep+0xab/0xd0
 [<c012b353>] profile_exit_task+0x23/0x60
 [<c012d849>] do_exit+0x79/0x9f0
[root@lap linux-2.6.0]# eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)
eth0: New link status: Disconnected (0002)
eth0: New link status: Connected (0001)



	

