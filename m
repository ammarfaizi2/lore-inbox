Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbSI2VzC>; Sun, 29 Sep 2002 17:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261817AbSI2VzC>; Sun, 29 Sep 2002 17:55:02 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35844 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S261816AbSI2VzB>; Sun, 29 Sep 2002 17:55:01 -0400
Date: Mon, 30 Sep 2002 00:00:19 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929220019.GH12928@merlin.emma.line.org>
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain> <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <20020929152652.GF29737@merlin.emma.line.org> <1033316647.13001.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033316647.13001.26.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Alan Cox wrote:

> On Sun, 2002-09-29 at 16:26, Matthias Andree wrote:
> > I personally have the feeling that 2.2.x performed better than 2.4.x
> > does, but I cannot go figure because I'm using ReiserFS 3.6 file
> 
> On low end boxes the benchmarks I did show later 2.4-rmap beats 2.2. 2.0
> worked suprisingly well (better than pre-rmap 2.4) and as Stephen
> claimed the best code was about 2.1.100, 2.2 then dropped badly from
> that point.

Granted, but I don't expect any roll-back to happen. If Stephen can dig
up the best version VM-wise, then if somebody could benchmark 2.6pre
against 2.1.BEST, that might be a good competition to 2.6pre -- modulo
different application profile, of course.

My major concern is usability: VM can be so bad it freezes hell or so
good it brings instant world peace: It won't buy me anything if I cannot
get to my data because LVM1 is unusable and neither EVMS nor LVM2 is in.
I'd like to test-drive 2.5, but booting my kernel and mounting a small
root partition from ext3 (non-LVM) and going without /usr and /opt
(because these are in LVM) is not terribly helpful to give it a try.

It's some big things that must be fixed before the tuning (towards
stability, fixes, performance) can take place. You really can't do the
tasting before you've put the meat in.
