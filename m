Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135541AbRDXLLe>; Tue, 24 Apr 2001 07:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135545AbRDXLLZ>; Tue, 24 Apr 2001 07:11:25 -0400
Received: from ns.suse.de ([213.95.15.193]:31243 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135541AbRDXLLL>;
	Tue, 24 Apr 2001 07:11:11 -0400
Mail-Copies-To: never
To: Joseph Carter <knghtbrd@debian.org>
Cc: Ville Herva <vherva@mail.niksula.cs.hut.fi>,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>, jh@suse.cz
Subject: Re: [Semi-OT] Dual Athlon support in kernel
In-Reply-To: <Pine.LNX.4.33.0104240115050.21785-100000@asdf.capslock.lan>
	<3AE52C2C.C6B2B472@mountain.net>
	<20010424131857.F3529@niksula.cs.hut.fi>
	<20010424033922.A5878@debian.org>
From: Andreas Jaeger <aj@suse.de>
Date: 24 Apr 2001 13:11:01 +0200
In-Reply-To: <20010424033922.A5878@debian.org> (Joseph Carter's message of "Tue, 24 Apr 2001 03:39:22 -0700")
Message-ID: <ho4rve364a.fsf@gee.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Carter <knghtbrd@debian.org> writes:

> On Tue, Apr 24, 2001 at 01:18:57PM +0300, Ville Herva wrote:
> > There's also AthlonLinux http://athlonlinux.org/ and AthlonGCC
> > http://athlonlinux.org/agcc/about.shtml, but I have no experience with those
> > (I have no Athlon ;( ).
> 
> A warning about agcc, I've discovered that it does not always compile code
> quite the way you expect it.  This is unsurprising given it's based on
> pgcc which is known to change alignments on you in ways that sometimes
> break things subtly.
> 
> 
> I do not know if agcc actually can produce code which simply does not work
> as is reported with pgcc (I suspect the alignment differences account for
> many of those cases), but I recall reading in the past few days that agcc
> is not supported for compiling the kernel.
> 
> It also fails to properly compile certain other programs, notably anything
> that includes asm functions.  As a result, my own experience suggests you
> consider agcc in the same class as gcc 3.0 at the moment - experimental.
> Hopefully the k7 optimizations that work well will find their way into a
> nice athlon subarch options in standard gcc and agcc won't be necessary.

Note that gcc 3.0 will have support for Athlons, -mcpu=athlon and
-march=athlon are both supported and will do the right thing.  For
details you should ask Jan Hubicka who implemented this some time ago,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
