Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265248AbSJaRod>; Thu, 31 Oct 2002 12:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSJaRod>; Thu, 31 Oct 2002 12:44:33 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:11534 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265248AbSJaRoc>;
	Thu, 31 Oct 2002 12:44:32 -0500
Date: Thu, 31 Oct 2002 18:49:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031174900.GA1210@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
	Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc> <20021031170420.GA30193@opus.bloom.county> <20021031171240.GE8565@mark.mielke.cc> <20021031172405.GB30193@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031172405.GB30193@opus.bloom.county>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 10:24:05AM -0700, Tom Rini wrote:
> Yes, and I'm saying that CONFIG_TINY shouldn't exist.  It should be
> CONFIG_FINE_TUNE (or so), to allow anyone to fine tune the optimization
> level.
If the flexibility is wanted then it should be something like:
CONFIG_TINY_GCCOPTFLAG
default 2
It should be a string so the developer can choose freely the optimisation
level.

	Sam
