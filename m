Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbTAGHAA>; Tue, 7 Jan 2003 02:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267324AbTAGHAA>; Tue, 7 Jan 2003 02:00:00 -0500
Received: from almesberger.net ([63.105.73.239]:59653 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267323AbTAGHAA>; Tue, 7 Jan 2003 02:00:00 -0500
Date: Tue, 7 Jan 2003 04:08:29 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <20030107040829.E1406@almesberger.net>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org> <3E19B401.7A9E47D5@linux-m68k.org> <17360000.1041899978@localhost.localdomain> <20030107042045.GA10045@waste.org> <200301070538.h075cICR004033@turing-police.cc.vt.edu> <20030107031638.D1406@almesberger.net> <200301070643.h076hWCR004411@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301070643.h076hWCR004411@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Tue, Jan 07, 2003 at 01:43:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> That's not the problem. The problem is that TCP slow-start itself (and some of
> the related congestion control stuff) has some issues scaling to the very high
> end.

I'm very well aware of that ;-) But what you wrote was:

> it takes *hours* without a
> packet drop to get the window open *all* the way

Or did you mean "after" instead of "without" ? Or maybe "into
equilibrium" instead of "the window open ..." ? (After all, the
window isn't only open, but it's been blown off its hinges.)

In any case, your statement accurately describes a somewhat
surprising quirk in Linux TCP performance as of only a bit more
than six years ago :)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
