Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292919AbSB0VMl>; Wed, 27 Feb 2002 16:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSB0VMN>; Wed, 27 Feb 2002 16:12:13 -0500
Received: from [207.68.163.82] ([207.68.163.82]:36619 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S292951AbSB0VLp>;
	Wed, 27 Feb 2002 16:11:45 -0500
X-Originating-IP: [192.219.23.189]
From: "Allo! Allo!" <lachinois@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel module ethics.
Date: Wed, 27 Feb 2002 16:11:38 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <F82zxvoEaZWNaBJjvmZ00001183@hotmail.com>
X-OriginalArrivalTime: 27 Feb 2002 21:11:38.0871 (UTC) FILETIME=[589C0870:01C1BFD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The company for whom I work wants to make a linux driver for some of its 
hardware. On my side I would like the driver to be completely open sourced, 
and from a customer point of view, its a big plus (a real PITA to maintain 
closed sourced drivers). On the other hand, the company wants a clear way to 
make "profit" from the work while still catering to it's customers whish to 
recompile the driver for just about any kernel version.

Here is what they propose... I do not know if what they are proposing is 
"going too far" regarding kernel module ethics, but I thought I'd ask the 
question here and see what other people think.

The hardware needs a firmware to run. Since this firmware is under NDA, the 
first compromise is to write the main part of the driver GPL but keep the 
firmware of the card in binary format. The driver can then load the firmware 
separately and this should not infringe on the GPL and I'm quite ok with 
this requirement. Now the problem is that any of our competitor's cards will 
work with the same closed sourced firmware and GPL engine. In pure 
capitalist thinking, the company finds this particularly troublesome...

The other compromise is to write a closed source part that would not permit 
the driver to work with another card supporting the same chipset. Is this 
kind of practice generally accepted or is it frowned upon? The motive of the 
company is quite clear. If people want to "improve" the driver, they can 
only improve it for their hardware, not the competitors. There is also a big 
marketing sales pitch that goes like "we support linux, the others 
don&#8217;t..."

It's like if Nvidia did not have linux drivers and ASUS wanted to ship a 
card with a linux driver that only works with asus cards even though there 
is one from leadtek with the exact same chipset (assuming that ASUS cannot 
change the internals of the card).

Is the second compromise just "going too far"? Is this better than simply 
having a 100% closed source driver?

Thanks!
Daniel Shane



_________________________________________________________________
MSN Photos est le moyen le plus simple de partager, modifier et imprimer vos 
photos préférées. http://photos.msn.fr/Support/WorldWide.aspx

