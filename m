Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267904AbRGZMzC>; Thu, 26 Jul 2001 08:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267908AbRGZMyv>; Thu, 26 Jul 2001 08:54:51 -0400
Received: from charybda.fi.muni.cz ([147.251.48.214]:43525 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S267904AbRGZMyj>; Thu, 26 Jul 2001 08:54:39 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Thu, 26 Jul 2001 14:54:42 +0200
To: Lutz Vieweg <lkv@isg.de>
Cc: linux-kernel@vger.kernel.org, unix@fi.muni.cz
Subject: Re: [Fwd: Linux 2.4 networking/routing slowdown]
Message-ID: <20010726145442.K1024@informatics.muni.cz>
In-Reply-To: <3B600EAD.3F8F9A70@isg.de> <3B6010EC.B7428A0D@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B6010EC.B7428A0D@isg.de>; from lkv@isg.de on Thu, Jul 26, 2001 at 02:45:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Lutz Vieweg wrote:
: We didn't investigate the problem further, but found that by using 
: "iptables" instead of the obsolete "ipchains" to establish the redirection
: rule, everything was fine again.
: 
: So my advice would be to try iptables and see if your problem goes away
: as well.
: 
	Well, the problem is, that even without ipchains.o module
loaded, the server is not able to route even nearly close to 100Mbps.
I'd like to have it routing at port speeds before I'll try to dig into
ipchains/iptables.

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
--Just returned after being 10 days off-line. Sorry for the delayed reply.--
