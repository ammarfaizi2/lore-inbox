Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132593AbRDBAu7>; Sun, 1 Apr 2001 20:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132597AbRDBAuu>; Sun, 1 Apr 2001 20:50:50 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:10025 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132593AbRDBAue>; Sun, 1 Apr 2001 20:50:34 -0400
Message-ID: <003001c0bb0e$100149b0$08080808@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "Trever L. Adams" <trever_Adams@bigfoot.com>,
   "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>
Cc: "linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10104011432180.5518-100000@coffee.psychology.mcmaster.ca> <3AC7B54C.2010706@bigfoot.com>
Subject: Re: Serial, 115Kbps, 2.2, 2.4
Date: Sun, 1 Apr 2001 20:44:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I do have a similar problem that I've been unable to track down
100%.  Under 2.4.x when I run the modem on my Xircom Cardbus 10/100
Ethernet/56K Modem combo card (installed in a Dell 5000e with 650Mhz Pentium
III) I get a fair number of dropped packets at 115Kbps, enough to cause
problems and a significant speed decrease.  Simply dropping the serial port
rate to 56K seems to solve the problem.  I'm actually suspicious that the
hardware handshaking isn't working quite right, but I haven't take the time
to look at it.

I never noticed the problem under 2.2.x, but the last kernel I ran from that
era was the 2.2.16 kernel included with Redhat 7.  I've really not looked at
it very hard, backing the speed down to 56K was a good enough solution for
me for now, the Xircom has such a troublesome history that I just blamed it
on that but your report makes me more curious.

Later,
Tom


