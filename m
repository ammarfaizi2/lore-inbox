Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135981AbRDTSuD>; Fri, 20 Apr 2001 14:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135980AbRDTSt4>; Fri, 20 Apr 2001 14:49:56 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:38641
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S135978AbRDTSts>; Fri, 20 Apr 2001 14:49:48 -0400
Date: Fri, 20 Apr 2001 14:48:18 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Tom Rini <trini@kernel.crashing.org>
cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>,
        lkml <linux-kernel@vger.kernel.org>, <parisc-linux@parisc-linux.org>
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is
 anyone paying attention?
In-Reply-To: <20010420112042.Z13403@opus.bloom.county>
Message-ID: <Pine.LNX.4.33.0104201440580.12186-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Tom Rini wrote:

> On Fri, Apr 20, 2001 at 12:35:12PM -0400, Nicolas Pitre wrote:
>
> > Why not having everybody's tree consistent with themselves and have whatever
> > CONFIGURE_* symbols and help text be merged along with the very code it
> > refers to?  It's worthless to have config symbols be merged into Linus' or
> > Alan's tree if the code isn't there (yet).  It simply makes no sense.
>
> Well, this depends a lot on a) The project to be merged (arch, mtd, whatever)
> and b) how far something has gotten in being merged someplace else, and of
> course c) the maintainer(s).  Whatever the exact case, and in general, it
> should be handled via the maintainer.  Why? They maintain the code.

Therefore it's the maintainer's job to submit coherent patches and accept to
see inconsistent CONFIG_* references be removed from the official tree until
further patch submission is due.  It's only a question of discipline.
Otherwise how can you distinguish between dead wood which must be removed
and potentially valid symbols referring to code existing only in a remote
tree?


Nicolas

