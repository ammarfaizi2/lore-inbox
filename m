Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSFJVBU>; Mon, 10 Jun 2002 17:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSFJVBT>; Mon, 10 Jun 2002 17:01:19 -0400
Received: from khms.westfalen.de ([62.153.201.243]:28582 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S315424AbSFJVBR>; Mon, 10 Jun 2002 17:01:17 -0400
Date: 10 Jun 2002 22:53:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8QbwdDPmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0206091130490.13751-100000@home.transmeta.com>
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 09.06.02 in <Pine.LNX.4.44.0206091130490.13751-100000@home.transmeta.com>:

> Is the "magic ioctl" approach ugly? Sure. But it's fairly well contained
> to just one program (ifconfig), and everybody else just uses that. I think
> it's less horrible than the alternatives right now.

If it *were* all contained in ifconfig, you'd be right, but that isn't  
even remotely true.

There are a *huge* number of programs that know about network interfaces.  
Apart from ifconfig, we have route, routed, iptables, ip, bootloads of  
admin scripts for device configuration, for firewalling, pppd anmd  
scripts, arp, dhcpd, portsentry, and I haven't even really scratched the  
surface here.

Sure, in the old times, when you could get Unix(tm) with or without the  
"networking option" for extra money, there wasn't much. But that has  
dramatically changed in these Internet times.


MfG Kai
