Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDUNNP>; Sat, 21 Apr 2001 09:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132605AbRDUNNG>; Sat, 21 Apr 2001 09:13:06 -0400
Received: from mail2.zrz.TU-Berlin.DE ([130.149.4.14]:1734 "EHLO
	mail2.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S132606AbRDUNMw>; Sat, 21 Apr 2001 09:12:52 -0400
Date: Sat, 21 Apr 2001 14:51:33 +0200
From: Daniel Dorau <woodst@cs.tu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: Inspiron 8000 does not resume after suspend
Message-ID: <20010421145133.A419@woodstock.home.xxx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
my Inspiron 8000 (BIOS A09) notebook running 2.4.3 does not resume 
after suspending. I have APM compiled in with the following options:

- Enable PM at boot time
- Make CPU Idle calls whe ide
- Enable console blanking using APM
- RTC stores time in GMT

Suspending with apm -s seem to work ok - at least it looks like.
Resuming however, does not work. There is a short disc
activity, then the harddrive LED is on for about 20 sec without
any noticable disc activity. Display doesn't switch on,
NIC (PCI, not PCMCIA) does not wake up (link LED stays off) and the
whole thing  keeps 'dead'.
With an older BIOS version that I upgraded because of a newer
ATI BIOS needed, it woke up execpt some PCI bridge(?) that I 
could re-activate with a setpci-script that I found in a
linux-kernel archive. So I think the problem is the same as
before.
Is there any way to fix that? I would really like to use
PM on my notebook.

Regards, 
Daniel

-- 
Daniel Dorau
woodst@cs.tu-berlin.de 
