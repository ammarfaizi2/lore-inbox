Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135986AbRDTSzN>; Fri, 20 Apr 2001 14:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135978AbRDTSzE>; Fri, 20 Apr 2001 14:55:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25101 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135983AbRDTSyu>;
	Fri, 20 Apr 2001 14:54:50 -0400
Date: Fri, 20 Apr 2001 19:50:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420195004.A5510@flint.arm.linux.org.uk>
In-Reply-To: <20010420101951.A6011@thyrsus.com> <E14qc9E-0001PW-00@the-village.bc.nu> <20010420105934.A6668@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010420105934.A6668@thyrsus.com>; from esr@thyrsus.com on Fri, Apr 20, 2001 at 10:59:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 10:59:34AM -0400, Eric S. Raymond wrote:
> All right then.  I'm going to send you a bunch of dead-symbol cleanup
> patches.  I'll try to stay in the mainline code and out of the port
> trees.  Would you please do me the kindness of telling me which ones
> can go in and which ones you think have to go through maintainers?

>From my point of view, I'd be happy if stuff that touched the ARM tree
directly was sent separately from the other architectures, and actually
was copied to me.  I'm sure that the other architecture maintainers
feel the same way, but I'll let them comment separately.

Why?  Well:

- Firstly, I can apply your patch directly to my tree without having
  to bother about the effects in the other architecture trees.  (hence
  when I resync with Linus or Alan, I don't have to go around fixing
  up rejects in other architecture trees).

- Secondly, its very easy to miss stuff in the lkml hunk of email each
  day when you have less than 4 hours to read it and think about it.
  (note that architecture maintainers have to read mail from their
  side which may not be on lkml, think about that, think about bug fixes,
  possible impacts of fixes on other machines, etc etc).  Therefore,
  copying their email address registered in the MAINTAINER file means
  that they should not overlook your patch.

- I know that Alan does take lots of patches off lkml, but I'm not sure
  what his criterion is for selecting them.  In the case which started
  this thread off, I'm always worried that your cleanup patch would make
  it in, and then cause me problems later on.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

