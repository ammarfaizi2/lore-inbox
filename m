Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291834AbSBAQVX>; Fri, 1 Feb 2002 11:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291833AbSBAQVN>; Fri, 1 Feb 2002 11:21:13 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:1705 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S291830AbSBAQVG>; Fri, 1 Feb 2002 11:21:06 -0500
Date: Fri, 1 Feb 2002 16:20:55 +0000
From: Anthony Campbell <ac@acampbell.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Repeated lockups caused by ext3?
Message-ID: <20020201162055.GA1318@debian.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the past couple of months I have been getting repeated lockups using
2.4 kernels; 2.4.17 at present. They always occur when I'm on line and
downloading, never at other times, and never on kernel 2.2.20. No
particular process seems to cause it. When it happens, all keys are
inoperative, the modem stops working, and the hard disk light is
permanently on.

They never occur on my laptop, using kernel 2.4.17.

They began to occur at about 2.4.10. I kept attributing them to VM
issues and fiddled with all sorts of things in the BIOS, without
result.

However, I've now found that they don't occur if I don't use ext3. This
therefore seems to be the answer in my case. Is this a known issue, and
is there any way of getting ext3 to work?

For the record: Processor is Intel Coppermine 600Mhz; 192M memory.
Not using hdparm.

Anthony


-- 
Anthony Campbell - running Linux GNU/Debian (Windows-free zone)
For an electronic book (The Assassins of Alamut), skeptical 
essays, and over 150 book reviews, go to: http://www.acampbell.org.uk/

Our planet is a lonely speck in the great enveloping cosmic dark. In our
obscurity, in all this vastness, there is no hint that help will come
from elsewhere to save us from ourselves. [Carl Sagan]



