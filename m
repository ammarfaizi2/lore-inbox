Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282914AbRL3Rxc>; Sun, 30 Dec 2001 12:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282684AbRL3RxW>; Sun, 30 Dec 2001 12:53:22 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:51610 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S283286AbRL3RxM>; Sun, 30 Dec 2001 12:53:12 -0500
Date: 30 Dec 2001 13:42:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org
Message-ID: <8FqGN-B1w-B@khms.westfalen.de>
In-Reply-To: <E16K6ID-0002Bk-00@the-village.bc.nu>
Subject: Re: [kbuild-devel] Re: State of the new config & build system
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E16K6ID-0002Bk-00@the-village.bc.nu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 28.12.01 in <E16K6ID-0002Bk-00@the-village.bc.nu>:

> > Frankly, I find it very amusing that advocates of i18n efforts tend to
> > be either British or USAnians.  Folks, get real - your languages are
> > too close to show where the problems are.  I can see how doing that
> > gives you a warm fuzzy feeling, but could you please listen to those
> > of us who have to deal with the resulting mess for real?
>
> The biggest advocates I see are from the Middle-East and Japan. We already
> have people providing translations for Configure.help in several languages.

Once upon a time, I installed the German version of the man pages. Shortly  
after that, I switched to doing "LANG= man ..." because of exactly the  
problem Al mentions.

But just recently I have been considering going back to the German man  
pages, because the quality has become *MUCH* better. In fact, it's now  
obvious they are fairly close translations of the English ones.

In short, i18n for Linux has been improving drastically at least in some  
areas. Of course that won't be the same for all target languages; German  
is probably one of the best-supported ones because Linux usage in Germany  
is so heavy.

As for Configure.help specifically: it should be fairly easy to do a  
script which notices when the original of a translation has changed, and  
possibly either replaces it with the English version, or else does some  
other more or less intelligent thing about it.

MfG Kai
