Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRH3ATs>; Wed, 29 Aug 2001 20:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269543AbRH3ATi>; Wed, 29 Aug 2001 20:19:38 -0400
Received: from [203.6.240.4] ([203.6.240.4]:63750 "HELO
	cbus613-server4.colorbus.com.au") by vger.kernel.org with SMTP
	id <S269515AbRH3AT1>; Wed, 29 Aug 2001 20:19:27 -0400
Message-ID: <370747DEFD89D2119AFD00C0F017E6614A62CF@cbus613-server4.colorbus.com.au>
From: Robert Lowery <Robert.Lowery@colorbus.com.au>
To: linux-kernel@vger.kernel.org
Subject: [Slightly OT]  Where should SIS 6326 mpeg2 hardware acceleration 
	code live?
Date: Thu, 30 Aug 2001 10:18:52 +1000
X-Mailer: Internet Mail Service (5.5.2650.21)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have recently acquired a PCI graphics card based on the SIS 6326 chipset.
This chipset supports YUV->RGB conversion, Hardware motion compensation and
iDCT in hardware.  Using Windows 98 and PowerDVD I am able to playback full
screen DVD without any skipped frames on a Pentium 233MMX.  All for the
cheap price of around $US20.

The full specs on this chipset are available at
http://www.sis.com/ftp/Databook/6326/6326ds10.exe

The hardware acceleration of this card does not appear to be supported under
linux, and I am unsure where the code should even go if I was to try and
write it.

I have tried mailing to the livid-devel@linuxvideo.org, as I first thought
this is where the code would belong, but have had no responses at all in 4
days.  Is this Livid/OMS project still alive.

Alternatives (that I am aware of) are
video4linux
fbcon
Xv

Where should this hardware support live, I suspect it does not belong in the
kernel ;) and who should I be talking to.  I am willing to do a lot of the
work to get this chipset supported, but since my device driver experience is
somewhat limited, I would probably need a mentor ;)

Please cc any repies to me as I am not subscribed

Cheers

-Robert
