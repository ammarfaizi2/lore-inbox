Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267367AbSLESxz>; Thu, 5 Dec 2002 13:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbSLESxz>; Thu, 5 Dec 2002 13:53:55 -0500
Received: from [203.199.93.81] ([203.199.93.81]:11786 "EHLO w16.indiatimes.com")
	by vger.kernel.org with ESMTP id <S267367AbSLESxx>;
	Thu, 5 Dec 2002 13:53:53 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200212051858.AAA02152@w16.indiatimes.com>
To: "Mihai RUSU" <dizzy@roedu.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: Re: disabling NMI events for kdb 2.1
Date: Fri, 06 Dec 2002 00:33:36 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

downloded the kernel source from kernel.org and applied kdb patch. (version linux-2.4.18.tar.gz, kdb-v2.1-2.4.18-common-1 and kdb-v2.1-2.4.18-i386-1
No problem with that.
I recompiled the kernel after enabling kdb in kernel hacking.
I have installed the newly compiled kernel.

My default run level was 5 (X windows).
I had problem in bringing up X Windows.
I changed the run level to 3.
system cam up well. I could press 'pause' and enter into kdb.
I could execute few commands. But as soon as I try to execute "go" command, system getting hanged. After that nothing works, keyboard getting locked.

Also can we see the C Source in kdb?

Have a nice time.
Arun



"Mihai RUSU" wrote:



Hi

I am using kdb 2.1 to hunt down a bug. This bug shows up after like 2 days
of uptime. Problem is that also on this system I get a unkown reason NMI
like:

Uhhuh. NMI received for unknown reason 21.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?

When it happens it enters kdb mode, thus the system "freezes".
Because I cannot be there to issue a "go" everytime it happens (line 4 am
:) ), it makes very hard to keep kdb enabled kernel running to wait for
the hunted bug to happen.

Is there a possibility to disable going to kdb mode when a "unkown reason"
NMI is received ? I could not find any usefull info in the kdb docs.

PS: this is the output from kdb on serial console when it receives the
NMI:
Entering kdb (current=0xcf142000, pid 31088) on processor 0 due to NonMaskable 3
eax = 0x00000051 ebx = 0x0804ebb0 ecx = 0x40017000 edx = 0x00000000
esi = 0x00000042 edi = 0x0804ebf8 esp = 0xbfffe094 eip = 0x08048fe3
ebp = 0xbfffe0ac xss = 0x0000002b xcs = 0x00000023 eflags = 0x00000202
xds = 0x0000002b xes = 0x0000002b origeax = 0x00000051 ®s = 0xcf143fc4

Thanks

----------------------------
Mihai RUSU


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/



Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

