Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284156AbRL1WaC>; Fri, 28 Dec 2001 17:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284195AbRL1W3w>; Fri, 28 Dec 2001 17:29:52 -0500
Received: from bitmover.com ([192.132.92.2]:10404 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284156AbRL1W3h>;
	Fri, 28 Dec 2001 17:29:37 -0500
Date: Fri, 28 Dec 2001 14:29:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011228142932.G3727@work.bitmover.com>
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <E16K1fn-0001Ky-00@the-village.bc.nu> <Pine.LNX.4.33.0112281400460.23445-100000@penguin.transmeta.com> <20011228170840.A20254@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011228170840.A20254@thyrsus.com>; from esr@thyrsus.com on Fri, Dec 28, 2001 at 05:08:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 05:08:40PM -0500, Eric S. Raymond wrote:
> What makes megabyte-large blocks of code bad is that they tend to be
> tangled messes with unmaintainable reference and control structures.
> Configure.help isn't; the entries are atoms that don't interact with
> each other.

Doesn't this statement miss the point that the configure stuff belongs with
the associated source, for many reasons?  Reasons being stuff like Linus'
desire to see PPC stuff only under the PPC directories, stuff like the
desire to have the config stuff as part of the source.  The very fact 
that they are atoms and don't interact with each seems to scream that they
should be located next to, or in, the stuff with which they do interact.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
