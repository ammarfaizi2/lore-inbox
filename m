Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317699AbSFLNWv>; Wed, 12 Jun 2002 09:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317700AbSFLNWu>; Wed, 12 Jun 2002 09:22:50 -0400
Received: from ns.suse.de ([213.95.15.193]:16903 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317699AbSFLNWu>;
	Wed, 12 Jun 2002 09:22:50 -0400
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, TRIVIAL] Fix argument of BLKGETSIZE64
In-Reply-To: <15622.54728.469214.307901@wombat.chubb.wattle.id.au>
	<E17I0sl-0004y0-00@wagner.rustcorp.com.au>
	<15623.11051.890868.154587@wombat.chubb.wattle.id.au>
X-Yow: I'm EXCITED!!  I want a FLANK STEAK WEEK-END!!  I think I'm JULIA
 CHILD!!
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 12 Jun 2002 15:22:48 +0200
Message-ID: <jey9dkhbrr.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> writes:

|> You could argue that this is a glibc bug.  But the way that glibc
|> generates the include/linux headers is just to copy them from some
|> kernel tree or other, with a little mangling on the side.

Glibc does not do anything with the kernel headers besides using some of
them.  Especially it does not generate any of them.  The fact that the
distributions usually pack the kernel headers together with the glibc
headers does not mean that the kernel headers belong to glibc.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
