Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274865AbRJALDL>; Mon, 1 Oct 2001 07:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274866AbRJALDB>; Mon, 1 Oct 2001 07:03:01 -0400
Received: from heimdall.inter.net.il ([192.114.186.17]:818 "EHLO
	heimdall.inter.net.il") by vger.kernel.org with ESMTP
	id <S274865AbRJALCv>; Mon, 1 Oct 2001 07:02:51 -0400
Message-Id: <5.1.0.14.2.20011001124524.028e54a0@pop3.norton.antivirus>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 01 Oct 2001 12:59:05 +0200
To: linux-kernel@vger.kernel.org
From: Gil Disatnik <Jewnix@technohac.com>
Subject: Strange behavior of kernel 2.4.10 & APM problems.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,
Not a while ago I have upgraded from Kernel 2.4.9 to 2.4.10 and I noticed 2 
strange things:
After I am done with the compilation and I am setting my lilo to load the 
new kernel, and then I am booting the machine
my machine gets stuck at boot time (before the init gets into action). this 
problem does NOT happen once I reboot the machine again and the kernel 
loads up straight with no problems, I then had to change a few things in 
the kernel's configuration (Tried playing with the APM a bit to see how 
come it's not working for me (I'll get to the apm issue soon...)) and I 
noticed that again - My machine gets stucked at boot time. Another reboot 
and that's it - works like a charm...
I played with it some more and I found out this:
Every fresh kernel I am running for the first time gets my machine freeze, 
after another boot everything is working well.
Please tell me what other information you need - I'll supply it (Please cc 
to me as well and not just the mailing list since I am not registered in 
the majordomo due to a serious bandwidth problems...)

Another issue is an APM problem on my Dell Latitude C600 laptop (The same 
machine with the 2.4.10 boot problems... which runs slack8 b.t.w.)
I can't suspend it, it gives a note stating "apm: Resource temporarily 
unavailable"...
I've attached an strace of the command and my kernel configuration.

Thanks in advance.


Regards

Gil Disatnik
UNIX system/security administrator@netish inc.
www.netish.com

GibsonLP@EFnet
_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
"Windows NT has detected mouse movement, you MUST restart
your computer before the new settings will take effect, [ OK ]"
--------------------------------------------------------------------
Windows is a 32 bit patch to a 16 bit GUI based on a 8 bit operating
system, written for a 4 bit processor by a 2 bit company which can
not stand 1 bit of competition.
-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

