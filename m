Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273723AbRIXAd2>; Sun, 23 Sep 2001 20:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273721AbRIXAdS>; Sun, 23 Sep 2001 20:33:18 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:59663 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273720AbRIXAdP>; Sun, 23 Sep 2001 20:33:15 -0400
Date: 24 Sep 2001 01:39:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <89VcLXc1w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0109232106020.14414-100000@vaio>
Subject: Re: do we need 10 copies?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3BAE2283.41E7E8E8@isn.net> <Pine.LNX.4.33.0109232106020.14414-100000@vaio>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)  wrote on 23.09.01 in <Pine.LNX.4.33.0109232106020.14414-100000@vaio>:

> On Sun, 23 Sep 2001, Garst R. Reese wrote:
>
> > This table (512 bytes) and the code to implement crc-ccit is replicated
> > in 10 drivers. ppp-async even exports it. Surely there is a better way.
>
> As for the ISDN code (4 copies), there is the plan to use a a common HDLC
> en/decoding module, however that's a 2.5 thing. I'll take a look if I can
> find a generic solution then, but it might turn out difficult - having a
> module of its own just for that table wastes nearly a page, so that's
> probably worse than the current state of affairs.

Why a module? Just make it something the base kernel exports, like other  
general library functions.

Oh, and ISTR that there are also still a number of zlib copies ... and,  
uh, about the PPP code ...

MfG Kai
