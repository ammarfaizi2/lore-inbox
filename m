Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133022AbRDKWt7>; Wed, 11 Apr 2001 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133023AbRDKWts>; Wed, 11 Apr 2001 18:49:48 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32727 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S133019AbRDKWti>;
	Wed, 11 Apr 2001 18:49:38 -0400
Subject: Re: [kbuild-devel] Re: CML2 1.0.0 release announcement
To: chastain@cygnus.com (Michael Elizabeth Chastain)
Date: Wed, 11 Apr 2001 23:25:36 +0100 (BST)
Cc: davej@suse.de, hch@caldera.de, esr@snark.thyrsus.com,
        kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200104112056.NAA20872@bosch.cygnus.com> from "Michael Elizabeth Chastain" at Apr 11, 2001 01:56:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nT3T-0007gI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Eric did some performance analysis.  If I recall correctly, all but 1
> or 2 seconds of CML2's runtime is in the parser.  He has rewritten the
> parser once.  Maybe someone needs to rewrite it again, maybe propagate
> some changes into the language spec to make it easier to parse, maybe
> rewrite from Python to C.

CML2 seems to have two other problems in my mind. Inability to parse the
existing config files. Also the draw ordering in the menu based config doesnt
appear right. Menuconfig has a rather undocumented but very important property
of doing roughly the right thing with screenreaders. Something to bear in mind
when fixing the menu redrawing stuff.

Alan



