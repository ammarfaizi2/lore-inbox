Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288944AbSAETr2>; Sat, 5 Jan 2002 14:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288940AbSAETrS>; Sat, 5 Jan 2002 14:47:18 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:60400 "HELO
	dardhal") by vger.kernel.org with SMTP id <S288944AbSAETrI>;
	Sat, 5 Jan 2002 14:47:08 -0500
Date: Sat, 5 Jan 2002 20:47:00 +0100
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020105194700.GB1283@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com> <3C2F04F6.7030700@athlon.maya.org> <3C309CDC.DEA9960A@megsinet.net> <20011231185350.1ca25281.skraw@ithnet.com> <3C351012.9B4D4D6@megsinet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C351012.9B4D4D6@megsinet.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 03 January 2002, at 20:14:42 -0600,
M.H.VanLeeuwen wrote:

> Here is what I've run thus far.  I'll add nfs file copy into the mix also...
> System: SMP 466 Celeron 192M RAM, running KDE, xosview, and other minor apps.
>
I applied your little patch "vmscan.patch.2.4.17.c" to a plain 2.4.17
source tree, recompiled, and tried it. Swap usage is _much_ less than in
original 2.4.17: hardware is a Pentium166 with 64 MB RAM and 75 MB
swap, and my workload includes X 4.1.x, icewm, nightly Mozilla, several
rxvt, gkrellm, some MP3 listening via XMMS, xchat, several links web
browsers and a couple of little daemons runnig.

I have not done scientific measures on swap usage, but with your patch
it seems caches don't grow too much, and swap is usually 10-20 MB lower
than using plain 2.4.17. I have also observed in /proc/meminfo that
"Inactive:" seems to be much lower with your patch.

If someone wants more tests/numbers done/reported, just ask.

Hope this helps.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

