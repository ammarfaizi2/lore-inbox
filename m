Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278662AbRKHWfb>; Thu, 8 Nov 2001 17:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRKHWfS>; Thu, 8 Nov 2001 17:35:18 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:27145 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S278662AbRKHWey>;
	Thu, 8 Nov 2001 17:34:54 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: frank@unternet.org
Date: Thu, 8 Nov 2001 23:34:38 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <8A11A922758@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Nov 01 at 22:24, Frank de Lange <frank@unterne wrote:
> > Only the big white switch helps (fsck'ing 80 gigs gives me enough time to make
> > a good cup of coffee... time for ext3 in the main kernel series...)

I tried Win2k and Netware6 (both 128MB) virtual machines running on 
the top of 2.4.15-pre1. My machine has 256MB RAM, SMP PIII/800. Maybe 
that it even worked faster than under Alan's kernel, specially when 
I tried to crash it by creating Netware6 256MB virtual machine - it 
stresses 256MB system a bit - but to my surprise system still stayed very
responsive, without any crash, of course. Only usual complaints when
running Netware6 as guest: 'rtc: lost some interrupts at 512Hz.'.

So I was not able to reproduce it. As I said, my system has 256MB of memory,
two PIII/800, 40GB IDE, some tulip based network card, and on background
it grabs some TV pictures using two bt878 pieces - so pretty standard box,
running unstable Debian with 4.1 XFree on mga g450.

There was no other activity during the testing AFAIK. 

If you see something different from your box, or from your VMs, tell me. 
But adding some SCSI adapter is beyond PCI slots of my box. I also
assume that you are using released VMware version, build 1455.
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
