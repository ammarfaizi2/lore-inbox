Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288732AbSADTvW>; Fri, 4 Jan 2002 14:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288735AbSADTvO>; Fri, 4 Jan 2002 14:51:14 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56790 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288732AbSADTvE>; Fri, 4 Jan 2002 14:51:04 -0500
Date: 04 Jan 2002 17:30:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8GDPkOJmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.3.95.1020103100747.4554A-100000@chaos.analogic.com>
Subject: Re: ISA slot detection on PCI systems?
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200201031431.g03EVLpa021956@pincoya.inf.utfsm.cl> <Pine.LNX.3.95.1020103100747.4554A-100000@chaos.analogic.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@chaos.analogic.com (Richard B. Johnson)  wrote on 03.01.02 in <Pine.LNX.3.95.1020103100747.4554A-100000@chaos.analogic.com>:

> ISA has nothing. Just fixed port addressing where an attempt
> is made to find out something about the hardware by writing
> and reading the results. If you think you have device 'A'
> at port N, but you don't, and you write something to condition
> device 'A' for a response, you could, in fact, tell another
> device to hit the reset switch or, worse, format your disk(s).

Best-known example is probably trying to autodetect anything but a NE2000  
card before detecting the NE2000 card that's in the machine.

I've even seen BIOSes freeze in that situation. And yes, I do mean whole- 
machine-freeze. An NE2000 *really* doesn't like being touched the wrong  
way.


MfG Kai
