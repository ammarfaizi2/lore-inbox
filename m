Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280388AbRKSXNk>; Mon, 19 Nov 2001 18:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280410AbRKSXNa>; Mon, 19 Nov 2001 18:13:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19215 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280388AbRKSXNU>; Mon, 19 Nov 2001 18:13:20 -0500
Message-ID: <3BF991D3.A5220A36@zip.com.au>
Date: Mon, 19 Nov 2001 15:12:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alex.buell@tahallah.demon.co.uk
CC: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3Com 3c905c invalid checksum?
In-Reply-To: <Pine.LNX.4.33.0111192234340.9417-100000@tahallah.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Buell wrote:
> 
> The network card in the docking station I plug my Inspirion 8100 in, is a
> 3Com 3c905C Tornado but apparently at boot time when it is identified, it
> prints "***INVALID CHECKSUM 00e0**. I can't ping other boxes on the
> network, nor can I ping other boxes from the laptop. I've double checked
> and triple checked, and the configuration is indeed correct.
> 
> What does the error message INVALID CHECKSUM means?
> 

It means that 3com keep on changing the EEPROM checksum
algorithm and nobody has got around to reverse engineering
it on the 905C.  It's harmless.

Usual routine: check the routing, check the counters
in `ifconfig'.  If it's really a driver problem, please
send me a description as per the final section of
Documentation/networking/vortex.txt

-
