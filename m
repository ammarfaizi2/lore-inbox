Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285366AbRLYFlN>; Tue, 25 Dec 2001 00:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285384AbRLYFlD>; Tue, 25 Dec 2001 00:41:03 -0500
Received: from [200.216.12.47] ([200.216.12.47]:45440 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S285366AbRLYFkq>; Tue, 25 Dec 2001 00:40:46 -0500
Date: Tue, 25 Dec 2001 03:40:59 -0200
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Matthew Johnson <matthew@psychohorse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EMU10K1: IRQ 10 ?
Message-ID: <20011225054059.GD148@pervalidus>
In-Reply-To: <20011225034725.GA148@pervalidus> <200112250401.fBP41E025476@barn.psychohorse.com> <20011225043232.GC148@pervalidus> <200112250440.fBP4eu025586@barn.psychohorse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200112250440.fBP4eu025586@barn.psychohorse.com>
User-Agent: Mutt/1.3.23.1i
X-Mailer: Mutt/1.3.23.1i - Linux 2.4.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 08:41:19PM -0800, Matthew Johnson wrote:
> On Monday 24 December 2001 08:32 pm, you wrote:

> > > I'd cheat and use sndconfig ot yast2 or whatever else.
> > > Failing that I can give you some idea via my modules.conf,
> > > but I use SuSE, whcih in turn uses Alsa.
> >
> > OK, so I'll try ALSA.
> >
> > My modules.conf just includes 'alias sound emu10k1'.

Dec 25 03:13:38 pervalidus kernel: PCI: Found IRQ 10 for device 00:0b.0

OK, ALSA worked, while OSS from the kernel didn't. I don't
know why.

I still have a problem. Sound is very distorted with a lot of
noise when I do a 'cat /home/ftp/pub/sound/ra/english.au >
/dev/audio' . Maybe my speakers are broken ? I never used
them before. Time to do more testing. Yes, I know nothing
about sound.

Thank you Matthew. Now if any kernel developer can answer why
OSS from the kernel didn't work...

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
