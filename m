Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288185AbSAQFso>; Thu, 17 Jan 2002 00:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288188AbSAQFsd>; Thu, 17 Jan 2002 00:48:33 -0500
Received: from ftp.cbu.skyinet.net ([202.78.112.67]:17868 "HELO
	ftp1.cbu.skyinet.net") by vger.kernel.org with SMTP
	id <S288185AbSAQFsT>; Thu, 17 Jan 2002 00:48:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: vernie@skyinet.net
Reply-To: vernie@skyinet.net
To: linux-kernel@vger.kernel.org
Subject: CM8338 hissing sound with linux kernel 2.4.6 to 2.4.17
Date: Thu, 17 Jan 2002 13:48:14 +0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020116.170852.91311984.davem@redhat.com> <Pine.GSO.4.40.0201161827510.28457-100000@apogee.whack.org> <20020116.211251.35505694.davem@redhat.com>
In-Reply-To: <20020116.211251.35505694.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020117054825Z288185-13996+7371@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Good day!

I have the same problems with C-Media 8338A soundchip and the problem still exists with 
linux kerner 2.4.17 and even with 2.4.18-pre3.  Only wav files can be played with 
no noise, mp3 and ogg files produce noisy hissing sound covering a somewhat 
delayed music. I believe this is a kernel related problem.

Anybody find a solution to the problem? I found out that not only me have the 
same problem. I have tried testing several releases of the linux kernel hoping someone 
got it fixed with each release but still have hissing noise.

I've tried the generic 2.4.17 linux kernel, one with rml and another with mjc patches 
and still have the same hissing noise every time I played mp3, ogg files using mpg123 or 
xmms.  I can only play .wav files with no noise using xmms or the command line "play" program.

The system is a PII 400MHz 440BX with an Audio Excel PCI soundcard (C-Media 8338A chip, using the 
cmpci kernel module), with bt848 tv tuner (works fine with it's own audio out), 
Mandrake 8.1 distribution (all required software by kernel to compile are installed).

-- 
Vernie


> From: CuPoTKa (cupotka@cupotka.dyn.ee)
>  Subject: Kernel 2.4.6 bug - problems with CM8338A soundchip. 
>  Newsgroups: mlist.linux.kernel
>  Date: 2001-07-16 00:40:32 PST 
> 
> 
> Part of kernel.log:
> kernel: cm: version $Revision: 5.64 $ time 01:44:06 Jul 16 2001
> kernel: PCI: Found IRQ 10 for device 00:0f.0
> kernel: cm: found CM8338A adapter at io 0xdc00 irq 10

> Problem: Sound isn't smooth. It makes strange noise instead music.

> I use:
> Linux version 2.4.6 (gcc version 2.95.4 20010703 (Debian prerelease)).
> Debian testing/unstable linux.
> Single PII, 400Mhz CPU.
> M748MR PCCHIPS motherboard.

> Usefull information: I compiled 2 kernels with CMedia 8338 chip support.
> One is kernel 2.4.5 and another 2.4.6. It works with 2.4.5 and dosn't with
> 2.4.6.

> Thanks.
