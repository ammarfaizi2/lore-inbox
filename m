Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280663AbRKBMQd>; Fri, 2 Nov 2001 07:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280672AbRKBMQX>; Fri, 2 Nov 2001 07:16:23 -0500
Received: from ns1.netnea.com ([138.189.116.70]:41144 "EHLO neo.netnea.com")
	by vger.kernel.org with ESMTP id <S280663AbRKBMQH>;
	Fri, 2 Nov 2001 07:16:07 -0500
Date: Fri, 2 Nov 2001 13:15:52 +0100
From: Charles Bueche <charles@bueche.ch>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM suspend/standby lockup (Notebook, Aver TM212)
Message-Id: <20011102131552.3a328eaa.charles@bueche.ch>
In-Reply-To: <20011102125153.A10624@munich.netsurf.de>
In-Reply-To: <20011102125153.A10624@munich.netsurf.de>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: 8_J3tE`<lbCYC,MPISj7Mm4]AA:G}E}:j,h,oP]yIP|^su@(x<{$?9)OY$b@&Q\S1s8Hbn4UG:XCBf&PY{+NsTYPJv`M;{e|x"mKj:ZJ3dWa[7!^WvafCL]Su><)i/Y(>`V^O9:"{`7@K'Z@:Wz}{vG~;pqkUDFP0X$:3+.|f5eCjB_uYe&gFhK1$k(\54r#T5{f1j3b--*,8_,fnOMh4Crn%WV7Ir4<sN|"!h
X-message-flag: Microsoft Outlook Fatal Error. Please reboot your system.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

any syslog output from the resume time ?

Charles

On Fri, 2 Nov 2001 12:51:53 +0100
OF = "Oliver Feiler <kiza@gmx.net>" wrote:
OF> Hello,
OF> 
OF> 	I have got this problem on an Acer Travelmate 212TX. Whenever I try
to 
OF> suspend the computer (via apm -s or closing the display) the system
suspends 
OF> nicely. When the system is powered up again the screen is restored but

OF> otherwise it's locked up. You cannot ping the computer or use the
SysReq keys.
OF> 
OF> 	The hardware seems quite new. Suspend works perfectly on an older 
OF> Travelmate 200 series notebook. Hardware in both notebook is the same
except 
OF> for the graphics card (the 210 uses a Trident Cyberblade builtin, the
200 a 
OF> ATI Rage Mobility M) and the Cardbus controller (210 has O2 Micro,
Inc. OZ6812 
OF> Cardbus Controller the 200 has O2 Micro, Inc. OZ6933 Cardbus
Controller). The 
OF> rest of the hardware seems to be the same.
OF> 
OF> 	I have tried suspend on 2.4.[9-13] kernels and an older 2.2.13 (from
a 
OF> Slackware 7.0 Live CD). Everytime the system crashes when it leaves
suspend 
OF> mode. I have also tested with a kernel with only the minimum drivers
compiled 
OF> into which had the same problem.
