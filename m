Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268079AbRHKPKS>; Sat, 11 Aug 2001 11:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbRHKPKI>; Sat, 11 Aug 2001 11:10:08 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:34055 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S268123AbRHKPKC>; Sat, 11 Aug 2001 11:10:02 -0400
Date: 11 Aug 2001 14:28:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <86efRzFmw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0108101503250.28666-100000@weyl.math.psu.edu>
Subject: Re: Writes to mounted devices containing file-systems.
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com> <Pine.GSO.4.21.0108101503250.28666-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 10.08.01 in <Pine.GSO.4.21.0108101503250.28666-100000@weyl.math.psu.edu>:

> On Fri, 10 Aug 2001, Richard B. Johnson wrote:

> > I have about 20 megabytes of logs showing the machine being
> > attacked from inside our firewall. Each time an attack occurred,
> > I would firewall-out its phony IP address (ipchains). A few hours
> > later the cycle repeated with another phony IP address.
>
> Instead of trying to see WTF was going on and fixing the problem instead
> of symptoms? _Real_ smart... Or, at least, block everything except the boxen
> that have any business accessing it? You know, with explicit "accept" rules
> in the beginning of the chain with catch-all "reject" after them...

Or at least use something like portsentry. Suspicious packets? Block  
first, ask questions later.

MfG Kai
