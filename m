Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132994AbRDKU4g>; Wed, 11 Apr 2001 16:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132996AbRDKU4Z>; Wed, 11 Apr 2001 16:56:25 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:46000 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S132994AbRDKU4X>;
	Wed, 11 Apr 2001 16:56:23 -0400
From: Michael Elizabeth Chastain <chastain@cygnus.com>
Date: Wed, 11 Apr 2001 13:56:19 -0700
Message-Id: <200104112056.NAA20872@bosch.cygnus.com>
To: davej@suse.de, hch@caldera.de
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
Cc: esr@snark.thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like mconfig, but I like CML2 better.

My primary reason is that ESR has more time to work on CML2 than I do
on mconfig.  And speed problems are often the easiest problems to solve.

Eric did some performance analysis.  If I recall correctly, all but 1
or 2 seconds of CML2's runtime is in the parser.  He has rewritten the
parser once.  Maybe someone needs to rewrite it again, maybe propagate
some changes into the language spec to make it easier to parse, maybe
rewrite from Python to C.

Michael
