Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbREPHYN>; Wed, 16 May 2001 03:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbREPHXx>; Wed, 16 May 2001 03:23:53 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:61712 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261808AbREPHXq>; Wed, 16 May 2001 03:23:46 -0400
Date: 16 May 2001 09:05:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80x0j1hHw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.10.10105151448150.22038-100000@www.transvirtual.com>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010515174339.A5599@sventech.com> <Pine.LNX.4.10.10105151448150.22038-100000@www.transvirtual.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jsimmons@transvirtual.com (James Simmons)  wrote on 15.05.01 in <Pine.LNX.4.10.10105151448150.22038-100000@www.transvirtual.com>:

> > > I couldn't agree with you more. It gives me headaches at work. One note,
> > > their is a except to the eth0 thing. USB to USB networking. It uses
> > > usb0, etc. I personally which they use eth0.
> >
> > USB to USB networking cables aren't ethernet.
>
> I'm talking about a wireless connection. ipaq USB cradle to PC.

I don't know about USB, but I do know about PPP.

The point is, Ethernet is *different* from PPP. The frame formats are  
different, even the protocols (aside from IP) are different.

It's similar to the difference between serial and parallel ports. Sure,  
for some things, they're the same - but for others, they really aren't,  
and that's why it makes sense to call the one ttyS0 and the other lp0.

Similar for eth0 vs. ppp0.

Yes, both are network interfaces. But no, you don't do ARP on ppp0, for  
example (you do LCP instead, and it does different stuff, too).

MfG Kai
