Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280694AbRKBOC1>; Fri, 2 Nov 2001 09:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280695AbRKBOCR>; Fri, 2 Nov 2001 09:02:17 -0500
Received: from p139.n04.ham.access.is-europe.net ([195.179.179.139]:9988 "HELO
	spot.local") by vger.kernel.org with SMTP id <S280694AbRKBOB5>;
	Fri, 2 Nov 2001 09:01:57 -0500
Date: Fri, 2 Nov 2001 15:02:24 +0100
From: Oliver Feiler <kiza@gmx.net>
To: Charles Bueche <charles@bueche.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM suspend/standby lockup (Notebook, Aver TM212)
Message-ID: <20011102150224.A14204@munich.netsurf.de>
In-Reply-To: <20011102125153.A10624@munich.netsurf.de> <20011102131552.3a328eaa.charles@bueche.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011102131552.3a328eaa.charles@bueche.ch>; from charles@bueche.ch on Fri, Nov 02, 2001 at 01:15:52PM +0100
X-Operating-System: Linux 2.4.13 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Bueche wrote:
> Hi,
> 
> any syslog output from the resume time ?

	No. :(  The last message that gets into the syslog is "apmd: User 
Suspend". Might there be a chance to capture something useful with a serial 
line console?


Oliver


> 
> Charles
> 
> On Fri, 2 Nov 2001 12:51:53 +0100
> OF = "Oliver Feiler <kiza@gmx.net>" wrote:
> OF> Hello,
> OF> 
> OF> 	I have got this problem on an Acer Travelmate 212TX. Whenever I try
> to 
> OF> suspend the computer (via apm -s or closing the display) the system
> suspends 
> OF> nicely. When the system is powered up again the screen is restored but
> 
> OF> otherwise it's locked up. You cannot ping the computer or use the
> SysReq keys.
> OF> 
> OF> 	The hardware seems quite new. Suspend works perfectly on an older 
> OF> Travelmate 200 series notebook. Hardware in both notebook is the same
> except 
> OF> for the graphics card (the 210 uses a Trident Cyberblade builtin, the
> 200 a 
> OF> ATI Rage Mobility M) and the Cardbus controller (210 has O2 Micro,
> Inc. OZ6812 
> OF> Cardbus Controller the 200 has O2 Micro, Inc. OZ6933 Cardbus
> Controller). The 
> OF> rest of the hardware seems to be the same.
> OF> 
> OF> 	I have tried suspend on 2.4.[9-13] kernels and an older 2.2.13 (from
> a 
> OF> Slackware 7.0 Live CD). Everytime the system crashes when it leaves
> suspend 
> OF> mode. I have also tested with a kernel with only the minimum drivers
> compiled 
> OF> into which had the same problem.

-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
