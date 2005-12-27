Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVL0Ofo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVL0Ofo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 09:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVL0Ofo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 09:35:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2443 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932326AbVL0Ofn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 09:35:43 -0500
Date: Tue, 27 Dec 2005 15:03:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Message-ID: <20051227140325.GA1620@elf.ucw.cz>
References: <200512210310.51084.kernel@kolivas.org> <20051225171617.GA6929@thunk.org> <20051226025525.GA6697@thunk.org> <20051226203806.GC1974@elf.ucw.cz> <20051226225246.GA9915@thunk.org> <20051226232712.GH1974@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051226232712.GH1974@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 27-12-05 00:27:12, Pavel Machek wrote:
> On Po 26-12-05 17:52:48, Theodore Ts'o wrote:
> > On Mon, Dec 26, 2005 at 09:38:06PM +0100, Pavel Machek wrote:
> > > Stupid IBM. I've seen it appearing/disappearing, but did not work out
> > > when.
> > > 
> > > No-C4-on-AC is bad -- if you just disconnect AC and walk away, you are
> > > running without benefits of C4. Bad. Changing benchmarks depending on
> > > you booting on AC or battery also look nasty.
> > 
> > The moment you disconnect AC, it C4 automagically appears.  When you
> > reconnect to the AC mains, the C4 state disappears again, at least
> > from the listing displayed by /proc/acpi/processor/CPU0/power.  So the
> > first issue you brought up isn't a problem.
> 
> It does not seem to work like that here. I'm not sure what the exact
> rules are, but I know that I sometimes have C4 and sometimes not. I
> have C4 now, and it is used, even when I'm on AC power. Thinkpad
> X32.

Well, today it _does_ behave like Theodore described (slightly
different kernel, and I'm using power supply, not docking
station). Strange.

								Pavel

-- 
Thanks, Sharp!
