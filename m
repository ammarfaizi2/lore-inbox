Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131207AbRBEXZF>; Mon, 5 Feb 2001 18:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135979AbRBEXYz>; Mon, 5 Feb 2001 18:24:55 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:53977 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S131207AbRBEXYn>; Mon, 5 Feb 2001 18:24:43 -0500
Message-ID: <3A7F3619.DC498502@alumni.caltech.edu>
Date: Mon, 05 Feb 2001 15:24:09 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Reply-To: dank@alumni.caltech.edu
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tony Finch <dot@dotat.at>, Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that
In-Reply-To: <E14Puvx-0004TB-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > How close is TCP_NOPUSH to behaving identically to TCP_CORK now?
> > If it does behave identically, it might be time to standardize
> > the symbolic name for this option, to make apps more portable
> > between the two OS's.  (It'd be nice to also standardize the
> > numeric value, in the interest of making the ABI's more compatible, too.)
> 
> That one isnt practical because of the way the implementations handle
> boolean options. BSD uses bitmask based option setting for the basic
> options and Linus uses switch statements

OK, well, at least a common symbolic name could be chosen.
- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
