Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRIHOWz>; Sat, 8 Sep 2001 10:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRIHOWq>; Sat, 8 Sep 2001 10:22:46 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:19464 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269777AbRIHOWg>; Sat, 8 Sep 2001 10:22:36 -0400
Date: 08 Sep 2001 15:16:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <88VMSqt1w-B@khms.westfalen.de>
In-Reply-To: <20010907112935.A26353@castle.nmd.msu.ru>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010906235157.D11046@mea-ext.zmailer.org> <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <20010906235157.D11046@mea-ext.zmailer.org> <20010907112935.A26353@castle.nmd.msu.ru>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

saw@saw.sw.com.sg (Andrey Savochkin)  wrote on 07.09.01 in <20010907112935.A26353@castle.nmd.msu.ru>:

[MTA]

> But how do you check for the destination IP being in the "local ones"?

Exim does it like this (approximately):

1. There is a list of domains considered "local".

2. There is an option that means the list will automatically contain the  
local hostname

3. There is another option that says the list will automatically include  
the [] notion of local interface addresses, as determined the usual way

4. The admin can add to that list anything (s)he wants.

(Note: 2 and 3 are both optional!)

As for netmasks: just use netmask notation when configuring how to treat  
hosts (such as who to allow relaying for). The probability that looking at  
the local network interfaces gives the right answer is close to zero.

MfG Kai
