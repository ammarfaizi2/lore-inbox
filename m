Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTELGH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 02:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTELGH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 02:07:28 -0400
Received: from imap.gmx.net ([213.165.65.60]:49003 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261944AbTELGH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 02:07:27 -0400
Date: Mon, 12 May 2003 08:17:43 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <443147.1052742876@[192.168.1.249]>
References: <3191078.1052695705@[192.168.1.249]>
	<17308.1052658225@www4.gmx.net>
	<443147.1052742876@[192.168.1.249]>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S261944AbTELGH1/20030512060727Z+7656@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003 12:34:36 +1200
Andrew McGregor <andrew@indranet.co.nz> wrote:

> Hi there...
> 
> --On Sunday, 11 May 2003 3:03 p.m. +0200 Tuncer M zayamut Ayaz 
> <tuncer.ayaz@gmx.de> wrote:
> 
> >> Reasoning:
> >> cpufreq and speedstep don't work on Dell P3 laptops anyway, and the
> >> *internal power supplies* of the i8x00 series make wierd noises
> >when APM> tries to idle the CPU.  The board will do this anyway,
> >without making
> >
> > hmm, at least now I know where that strange sound comes from.
> > I'm not quite sure that SpeedStep does not work,
> > with SpeedStep disabled in the BIOS the fans turned on again with
> > cpu load. this doesn't happen with SpeedStep. so I suppose it works
> > to some extent, right?
> 
> Sounds like it to me.  It certainly does not work on my i8000, but the
> 8100 is possibly different.

one thing none of you most probably wants to hear:
if this "APM idle calls" is that "HLT" stuff, then I have to tell you
that on win32 I had not such problems while using the CpuIdle tool.
sorry.

> >
> >> noise, so linux need not.
> >
> > so what options should I set?
> > as I've already stated it's not bearable to do coding (incl.
> > compiling) on this box without "Battery Optimized Mode" as SpeedStep
> > calls it. on Linux I did that with a simple tool called speedstep.
> > I've seen autospeedstep from Fritz Ganter which seems to use ACPI,
> > dunno how that compares to cpufreqd.
> 
> Hmm.  Maybe the 8100 has working speedstep, then.  I'd suggest you see
> if disabling just the APM idle calls, but leaving speedstep and
> cpufreq on makes the noise.

as time permits. didn't mess around with ACPI or CpuFreq before.

> I have had no success whatever with ACPI on an i8000, but again an
> 8100 may be different.


may be, but for now somehow 2.5.69 segfaults in /etc/init.d/pcmcia :(
could be the PCMCIA changes I read in the -69 changelog
quote: "don't unload PCMCIA"

ok, it happened while loading.
anyway, waiting for -70 or some -bk* patchset that fixes PCMCIA up

any PCMCIA fixes already available in linus -bk?

does CpuFreq depend on ACPI ? just in case i8k1 doesn't have proper
ACPI support.

> >
> > anyway, this laptop is not-so-nice anyway, I'm just happy I didn't
> > buy it but my employer did ;)
> 
> Same here, and I mostly agree.  Good price for such a nice screen,
> though (I have the 1600x1200 15" screen).

yep.
