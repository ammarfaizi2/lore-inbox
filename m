Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271715AbTG3DUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 23:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271739AbTG3DUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 23:20:00 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:37306 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271715AbTG3DT7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 23:19:59 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Wed, 30 Jul 2003 00:19:56 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb and 2.6.0-test2
In-Reply-To: <8A361F82D2E@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.56.0307291721010.153@pervalidus.dyndns.org>
References: <8A361F82D2E@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Petr Vandrovec wrote:

> On 29 Jul 03 at 16:41, Frédéric L. W. Meunier wrote:
> > On Tue, 29 Jul 2003, Petr Vandrovec wrote:
>
> > > Unless it gets proven that it is bug in kernel's matroxfb and not
> > > in generic fbcon (== if you'll send me a patch, I'll apply it; but do
> > > not expect that I'll hunt down bugs which do not occur with matroxfb-2.5.72
> > > addon), I recommend you applying
> > > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.72.gz.
> > > It reinstates back fbcon layer I understand & trust...
> >
> > 2 other problems went away with your patch. When I reported no
> > screen corruption I was wrong since it messed everything
> > returning from XFree86, including getting a dump of a Windows
> > reboot. The other is the boot logo, which now appears.
>
> I think that screen corruption is just timming issue, and you
> should see it... On PII/333, with G400, Debian's XF4.2.1-9, if
> I set clocks in Gnome2 to show seconds, hardware is again reprogrammed
> every second by XFree on the background...

Here Athlon XP 1700+, XFree86 4.3.0.1, IceWM 1.2.9. Clocks with
seconds on both window manager and screen, but it happens
without them and if I just startx and close it. As I reported
it doesn't happen with your patch, but I may be seeing the
other "problem" you mentioned at
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D105908939813118&w=3D2

"BTW, with my patch accented characters works correctly only on
VT1.  I'm not sure how it behaves on Linus tree..."

Same behavior without your patch. Here I use setfont
lat1-16.psfu in my init scripts. All accents work on the first
console but on the others most miss them for capitals.
