Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132561AbRDQGQ2>; Tue, 17 Apr 2001 02:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRDQGQS>; Tue, 17 Apr 2001 02:16:18 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:42119 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S132561AbRDQGQJ>; Tue, 17 Apr 2001 02:16:09 -0400
Date: Tue, 17 Apr 2001 08:16:00 +0200 (CEST)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
cc: Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <20010417003811.A4385@kallisto.sind-doof.de>
Message-Id: <Pine.LNX.4.31.0104170808080.6365-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Andreas Ferber wrote:

> > Okay, but at least take a better signal than SIGINT, probably one that the
> > init maintainers like so it gets adopted faster (or extend SIGPWR).

> Extending SIGPWR will break inits not yet supporting the extensions,
> so this is IMO not an option. There should be used some other signal
> which is simply ignored by an old init.

Make it a config option then; the short description says "read help", the
long help says "you need init version x.y". People compiling their own
kernels should know what they're doing, and distributors usually know what
init they are packaging.

> The distribution of such events to other userspace processes (if there
> are some that want to receive a subset of the events) can be perfectly
> done by init, so we should IMO keep this stuff out of the kernel (I
> don't think that the processing of such events will ever be
> performance critical).

Fine with me as long as I get a decent interface where the policy manager
can plug into. :-)

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

