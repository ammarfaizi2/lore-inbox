Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290727AbSARP5m>; Fri, 18 Jan 2002 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290728AbSARP5c>; Fri, 18 Jan 2002 10:57:32 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27871 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S290727AbSARP5W>; Fri, 18 Jan 2002 10:57:22 -0500
Subject: Full-duplex not working with i810_audio
From: Jean-Marc Valin <valj01@gel.usherb.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 18 Jan 2002 10:57:22 -0500
Message-Id: <1011369443.1395.15.camel@idefix.homelinux.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get full-duplex audio to work on my laptop with 2.4.17 (using
the i810_audio sound driver). I know my card (ADI 188x WDM) supports it
because it works fine with the commercial OSS. 

In the sample code:
   fd = open("/dev/dsp", O_RDWR);
   ioctl(fd, SNDCTL_DSP_SETDUPLEX, 0)
I get:
SNDCTL_DSP_SETDUPLEX: Invalid argument

Also, when using the "rec" (based on sox) utility, my kernel crashes
completely (no panic, no oops, nothing else happens).

My setup is:
Compaq Presario 1720CA
PIII mobile 1 GHz / 256 MB RAM
ATI Mobility Radeon M6 / 8 MB
ADI 188x WDM sound chip (on-board)
RedHat 7.2/2.4.17

Can anyone help me? 

	Jean-Marc

P.S. Please CC to me, as I am not subscribed to the list

