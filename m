Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279602AbRJXVQG>; Wed, 24 Oct 2001 17:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRJXVPq>; Wed, 24 Oct 2001 17:15:46 -0400
Received: from tamago.synopsys.com ([204.176.20.21]:39126 "EHLO
	tamago.synopsys.com") by vger.kernel.org with ESMTP
	id <S279602AbRJXVPh>; Wed, 24 Oct 2001 17:15:37 -0400
Message-ID: <3BD72F8F.43E21E66@Synopsys.COM>
Date: Wed, 24 Oct 2001 23:15:59 +0200
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12-preempt i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Alsa 0.9beta8a with 2.4.{12,13} ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Up to kernel version 2.4.12 the Alsa 0.9beta8a version was working
for my needs. Sometimes the startup script claimed that there is
no soundcard (via686a), but after one or two restarts of this 
script the onboard chip was detected.

With 2.4.13 I had no such luck:

{root@bilbo:harri 937} /etc/init.d/alsasound restart
Shutting down sound driver: done
Starting sound driver: snd-card-via686a Warning: loading /lib/modules/2.4.13/misc/snd.o will taint the kernel: no license
Warning: loading /lib/modules/2.4.13/misc/snd-seq-device.o will taint the kernel: no license
Warning: loading /lib/modules/2.4.13/misc/snd-rawmidi.o will taint the kernel: no license
Warning: loading /lib/modules/2.4.13/misc/snd-mpu401-uart.o will taint the kernel: no license
Warning: loading /lib/modules/2.4.13/misc/snd-timer.o will taint the kernel: no license
Warning: loading /lib/modules/2.4.13/misc/snd-pcm.o will taint the kernel: no license
Warning: loading /lib/modules/2.4.13/misc/snd-ac97-codec.o will taint the kernel: no license
Warning: loading /lib/modules/2.4.13/misc/snd-card-via686a.o will taint the kernel: no license
done
/usr/sbin/alsactl: load_state:1026: No soundcards found...


I get this _every_ time with 2.4.13 . 


Of course I know that this is not the Alsa EMail list. But
maybe you have some ideas which change has broken Alsa
completely and give the Alsa folks a hint.


Many thanx

Harri
