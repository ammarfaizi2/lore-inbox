Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135979AbRBEX0f>; Mon, 5 Feb 2001 18:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135997AbRBEX0Z>; Mon, 5 Feb 2001 18:26:25 -0500
Received: from sfo-gw.covalent.net ([207.44.198.62]:53574 "EHLO hand.dotat.at")
	by vger.kernel.org with ESMTP id <S135932AbRBEX0M>;
	Mon, 5 Feb 2001 18:26:12 -0500
Date: Mon, 5 Feb 2001 23:24:49 +0000
From: Tony Finch <dot@dotat.at>
To: Dan Kegel <dank@alumni.caltech.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Finch <dot@dotat.at>
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that sexy?)
Message-ID: <20010205232449.H70673@hand.dotat.at>
In-Reply-To: <3A66729E.3E9E3C64@alumni.caltech.edu> <Pine.LNX.4.10.10101172046170.17109-100000@penguin.transmeta.com> <20010202013104.A48377@hand.dotat.at> <20010205225411.E70673@hand.dotat.at> <3A7F3420.A3B10510@alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A7F3420.A3B10510@alumni.caltech.edu>
Organization: Covalent Technologies, Inc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel <dank@alumni.caltech.edu> wrote:
>
>How close is TCP_NOPUSH to behaving identically to TCP_CORK now?

They are exactly the same.

>If it does behave identically, it might be time to standardize
>the symbolic name for this option, to make apps more portable
>between the two OS's.  (It'd be nice to also standardize the
>numeric value, in the interest of making the ABI's more compatible, too.)

I wonder if it's a bit late for that now...

This reminds me to make sure that FreeBSD's Linux emulation supports
TCP_CORK properly.

Tony.
-- 
f.a.n.finch    fanf@covalent.net    dot@dotat.at
" ``Well, let's go down and find out who's grave it is.''
``How?''  ``By going down and finding out!'' "
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
