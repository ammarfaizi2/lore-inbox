Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292917AbSBVP4T>; Fri, 22 Feb 2002 10:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSBVP4K>; Fri, 22 Feb 2002 10:56:10 -0500
Received: from ns.suse.de ([213.95.15.193]:49418 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292916AbSBVPz5>;
	Fri, 22 Feb 2002 10:55:57 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Jes Sorensen <jes@trained-monkey.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Troy Benjegerdes <hozer@drgw.net>, wli@holomorphy.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
	<20020207234555.N17426@altus.drgw.net>
	<5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
	<d37kp5v9y5.fsf@lxplus050.cern.ch>
	<3C7660F5.FC238A7E@mandrakesoft.com>
	<15478.25001.512565.628500@trained-monkey.org>
	<3C76631C.E685815D@mandrakesoft.com>
X-Yow: AIEEEEE!  I am having an UNDULATING EXPERIENCE!
From: Andreas Schwab <schwab@suse.de>
Date: Fri, 22 Feb 2002 16:55:45 +0100
In-Reply-To: <3C76631C.E685815D@mandrakesoft.com> (Jeff Garzik's message of
 "Fri, 22 Feb 2002 10:26:20 -0500")
Message-ID: <jepu2xzf26.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

|> Jes Sorensen wrote:
|> > 
|> > >>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
|> > 
|> > Jeff> Jes Sorensen wrote:
|> > >> __mc68000__ is the correct define, I don't know who put in
|> > >> CONFIG_M68K but it doesn't belong there.
|> > 
|> > Jeff> I disagree -- look at arch/*/config.in.
|> > 
|> > Jeff> Each arch needs to define a CONFIG_$ARCH.
|> > 
|> > Why? CONFIG_$ARCH only makes sense if you can enable two architectures
|> > in the same build. What does CONFIG_M68K give you that __mc68000__
|> > doesn't provide?
|> 
|> 1) it is a Linux kernel standard.  all arches save two define
|> CONFIG_$arch.
|> 
|> 2) you have two tests, "ARCH==m68k" in config.in and "__mc68000__" in C
|> code.  CONFIG_M68K means you only test one symbol, the same symbol, in
|> all code.
|> 
|> 3) as this thread shows, due to #1, users -expect- that CONFIG_M68K will
|> exist

If consistency is your goal then CONFIG_I386 should be defined.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
