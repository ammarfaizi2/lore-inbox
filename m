Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVCBTZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVCBTZF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVCBTXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:23:13 -0500
Received: from zeus.bragatel.pt ([217.70.64.253]:62985 "HELO mail.bragatel.pt")
	by vger.kernel.org with SMTP id S262427AbVCBTSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:18:35 -0500
Date: Wed, 2 Mar 2005 19:14:10 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: Dave Jones <davej@redhat.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050302191410.GA9292@hobbes.itsari.int>
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain> <20050302075037.GH20190@apps.cwi.nl> <20050302080255.GA28512@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20050302080255.GA28512@redhat.com> (from davej@redhat.com on Wed, Mar 02, 2005 at 08:02:55 +0000)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005.03.02 08:02, Dave Jones wrote:
> 
> The Winchips never really sold that well, and stopped being produced
> when IDT sold off Centaur.  It was a niche processor in 1997. In 2005,
> I'll be surprised if there are that many of them still working.
> Mine lost its magic smoke for no reason around ~2002.
> 
> If there are any of them still being used out there, I'd be even
> more surprised if they're running 2.6.  Then again, there are
> probably loonies out there running it on 386/486's. 8-)
>

Heh. Let me brag about it a little:

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 5
model           : 4
model name      : WinChip C6
stepping        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de msr mce cx8 mmx centaur_mcr cid
bogomips        : 399.76

$ uname -a
Linux kawasaki 2.6.10-rc3 #3 Fri Dec 17 21:44:53 CET 2004 i586 unknown

$ uptime
 19:00:14 up 58 days,  1:21,  1 user,  load average: 0.37, 0.17, 0.11

Running 2.6 at least since 2.6.0-test11-wli-something, dated Dec 6 2003  
according to /boot (may have been running other 2.6-test before, but I  
dont have them around any longer):

$ ls -al /boot/vmlinuz-2.6.0-test11
-rw-r-----    1 root     root       840607 Dec  6  2003 /boot/vmlinuz- 
2.6.0-test11-wli


Not a single hiccup, so far *knock on wood*. Bragging even further, I  
also have a genuine 80386 DX 33 up and running, although that one is  
still on 2.0.37, iirc.

Oh, yes, I'm a loonie ;-)


Regards,


		Nuno

