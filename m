Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315852AbSEGPDS>; Tue, 7 May 2002 11:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315853AbSEGPDR>; Tue, 7 May 2002 11:03:17 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24080 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315852AbSEGPDQ>; Tue, 7 May 2002 11:03:16 -0400
Date: Tue, 7 May 2002 17:03:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andy Carlson <naclos@andyc.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
Message-ID: <20020507170331.P31998@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44.0205061106050.2878-100000@ancyc> <E1756Ax-0007gM-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 03:42:47PM +0100, Alan Cox wrote:
> Tux has a lot of other things that make it questionable for merging -
> incredibly so for 2.4 - it sticks its fingers into task structs, dcache

I don't buy that, so you may want to give us an answer for why is it
included into the redhat 2.4 kernel if according to you it's incredibly
questionable for merging into 2.4?

I merged it and it's trivial to merge, all "questionable" patches are
obviously safe.

If Marcelo accepts my patches, I will be very glad to replace khttpd
with tux into mainline 2.4. The two products are completly equivalent
and risking to increase the khttpd userbase just because tux isn't in
mainline doesn't make any sense to me, it can only waste resources.
(despite it makes much more sense to use zope, apache, servlets and php
instead of tux for anything real, first of all for security reasons, but
that's another issue, here the issue is khttpd vs tux and this one is a
no brainer)

Andrea
