Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289809AbSAKAjh>; Thu, 10 Jan 2002 19:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289808AbSAKAj1>; Thu, 10 Jan 2002 19:39:27 -0500
Received: from basket.ball.reliam.net ([213.91.6.7]:43023 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S289806AbSAKAjQ>; Thu, 10 Jan 2002 19:39:16 -0500
Message-ID: <3C3E343E.9030903@gmx.net>
Date: Fri, 11 Jan 2002 01:39:26 +0100
From: Michael Klose <mkmail@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.7+) Gecko/20020110
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange: load=stable, running idle=unstable
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently had problems with 2 eepro100 cards in my system. I could 
crash the kernel (only reboot helped) if I copied a 700 MB file to the 
server. It crashed after 100 MB or so.

I experimented a bit with the intel eepro drivers, the kernel drivers as 
a loadable module, compiled in etc, but it all didn't make much difference.

I had the most problems with 2.4.17 (vanilla). The most stable kernel 
seemed to be 2.4.15pre5.

I found out that the kernel stays absolutely stable if it is under load. 
I first tried compiling a kernel non stop for 3 days in a loop. System 
was absolutely stable.

I switched from non-stop compiling to running setiathome. Also makes the 
kernel run beautifully.

But as soon as the kenel is doing nothing except light routing of the 
768/128kbit DSL into the 100 MBit LAN and mainly running idle, as soon 
as you try and copy a large file via SMB - kaboom - kernel crashes.

Hardware: Soyo BX Dual PII motherboard with a single PII 266. 2 IDE HDDs 
(Maxtor) and a ATI PCI graphics card (no framebuffer or so compiled in, 
and no X, it is a server). SMB support is not compiled in, neither is 
any form of power management.

I thought this may be interesting to some people.


