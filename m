Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272856AbRIRIbs>; Tue, 18 Sep 2001 04:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272871AbRIRIbi>; Tue, 18 Sep 2001 04:31:38 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:13843 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272856AbRIRIbZ>; Tue, 18 Sep 2001 04:31:25 -0400
Date: Tue, 18 Sep 2001 10:31:21 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: Jeffrey Ingber <jhingber@ix.netcom.com>
Cc: linux-kernel@vger.kernel.org, xpert@XFree86.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [FIXED] Random Sig'11 in XF864 with kernel > 2.2.x
Message-ID: <20010918103121.B763@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Jeffrey Ingber <jhingber@ix.netcom.com>,
	linux-kernel@vger.kernel.org, xpert@XFree86.org,
	alan@lxorguk.ukuu.org.uk
In-Reply-To: <3BA6D4C0.1010309@ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA6D4C0.1010309@ix.netcom.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Ingber wrote:

> The problem mentioned in the following threads:
> 
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0109.1/0932.html
> http://www.xfree86.org/pipermail/xpert/2001-September/011055.html
> http://www.xfree86.org/pipermail/xpert/2001-September/011230.html
> 
> Is fixed in at least 2.4.9-ac10.  I haven't been a regular user of the 
> -ac series so I can't say when exactly this was fixed.  However, this 
> problem still persists in Linus 2.4.10-pre10.  Can anyone who chimed in 
> with similar problems to mine try said kernel (2.4.9-ac10) and provide 
> any feedback?  It would excellent if the exact fix could be identified.

I'm using ac-10 with the preempt patch at the moment and still have
trouble with the X server segfaulting sometimes.
Usually it does this not that often (once a day to once every few days),
it seems more likely to happen when switching between text mode console
and X, I can increase the likelyhood of this by running the wmcpu and
wmsysmon applets, which will often make it segfault after only a few minutes.
System is Dual Celeron 433 on an ABIT BP6 board. XFree 4.1.0. Debian
unstable. Riva TNT, using the nv driver. (I sometimes switch to the
nvidia driver because this supports the xvideo extensions, but have not
since the last reboot, so the proprietary module should not have been
loaded)
The most annoying thing is that the console is stuck in graphics mode
after the server crashed...

-- 
Tobias								PGP: 0x9AC7E0BC
Hannover Fantreffen ML: mailto:fantreffen-request@mantrha.de?subject=subscribe
Manga & Anime Treff Hannover: http://www.mantrha.de/
