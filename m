Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273328AbRIRK2a>; Tue, 18 Sep 2001 06:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273329AbRIRK2V>; Tue, 18 Sep 2001 06:28:21 -0400
Received: from smtp008pub.verizon.net ([206.46.170.187]:48002 "EHLO
	smtp008pub.verizon.net") by vger.kernel.org with ESMTP
	id <S273328AbRIRK2R>; Tue, 18 Sep 2001 06:28:17 -0400
Message-ID: <3BA721BF.30C37C52@verizon.net>
Date: Tue, 18 Sep 2001 05:28:15 -0500
From: Polymorphic Anomaly <linux.geeke@verizon.net>
Organization: Leeding Technologies
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Diedrich <ranma@gmx.at>
CC: Jeffrey Ingber <jhingber@ix.netcom.com>, linux-kernel@vger.kernel.org,
        xpert@XFree86.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [FIXED] Random Sig'11 in XF864 with kernel > 2.2.x
In-Reply-To: <3BA6D4C0.1010309@ix.netcom.com> <20010918103121.B763@router.ranmachan.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had this problem as well, and i finally gave up until i could get a Voodoo
or Rage 128, which have DRM, etc etc. My current card is a savage 4.  After
tryintg all the patches and everything. i finally just disabled the nice
framebuffer consoles so that when X crashes it doesnt take the consoles with it..
does anyone knoe of a real fix?

Poly


Tobias Diedrich wrote:

> Jeffrey Ingber wrote:
>
> > The problem mentioned in the following threads:
> >
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0109.1/0932.html
> > http://www.xfree86.org/pipermail/xpert/2001-September/011055.html
> > http://www.xfree86.org/pipermail/xpert/2001-September/011230.html
> >
> > Is fixed in at least 2.4.9-ac10.  I haven't been a regular user of the
> > -ac series so I can't say when exactly this was fixed.  However, this
> > problem still persists in Linus 2.4.10-pre10.  Can anyone who chimed in
> > with similar problems to mine try said kernel (2.4.9-ac10) and provide
> > any feedback?  It would excellent if the exact fix could be identified.
>
> I'm using ac-10 with the preempt patch at the moment and still have
> trouble with the X server segfaulting sometimes.
> Usually it does this not that often (once a day to once every few days),
> it seems more likely to happen when switching between text mode console
> and X, I can increase the likelyhood of this by running the wmcpu and
> wmsysmon applets, which will often make it segfault after only a few minutes.
> System is Dual Celeron 433 on an ABIT BP6 board. XFree 4.1.0. Debian
> unstable. Riva TNT, using the nv driver. (I sometimes switch to the
> nvidia driver because this supports the xvideo extensions, but have not
> since the last reboot, so the proprietary module should not have been
> loaded)
> The most annoying thing is that the console is stuck in graphics mode
> after the server crashed...
>
> --
> Tobias                                                          PGP: 0x9AC7E0BC
> Hannover Fantreffen ML: mailto:fantreffen-request@mantrha.de?subject=subscribe
> Manga & Anime Treff Hannover: http://www.mantrha.de/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

