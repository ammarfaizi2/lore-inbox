Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423108AbWJQFWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423108AbWJQFWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 01:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423109AbWJQFWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 01:22:44 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:27147 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1423108AbWJQFWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 01:22:44 -0400
Date: Tue, 17 Oct 2006 01:22:09 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org,
       Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix typos in doc and comments (1)
Message-Id: <20061017012209.c764a3ec.kernel1@cyberdogtech.com>
In-Reply-To: <20061016160738.2199bbcb.rdunlap@xenotime.net>
References: <Pine.LNX.4.61.0610170040510.30479@yvahk01.tjqt.qr>
	<20061016160738.2199bbcb.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Tue, 17 Oct 2006 01:22:21 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 17 Oct 2006 01:22:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 16:07:38 -0700
Randy Dunlap <rdunlap@xenotime.net> wrote:

> On Tue, 17 Oct 2006 00:50:56 +0200 (MEST) Jan Engelhardt wrote:
> 
> > 
> > 
> > Changes persistant -> persistent. www.dictionary.com does not know 
> > persistant (with an A), but should it be one of those things you can 
> > spell in more than one correct way, let me know.
> 
> I agree with it, but IIRC Alan said it could be either way.
> 

While I also agree, you're correct about Alan's claim.  He used a print dictionary...I've yet to find an online dictionary that supports this spelling.  (Note: I've found m-w.com to be the best at catching both British English and American English spellings.  Cambridge online is good too).

> > Index: linux-2.6.19-rc2/lib/textsearch.c
> > ===================================================================
> > --- linux-2.6.19-rc2.orig/lib/textsearch.c
> > +++ linux-2.6.19-rc2/lib/textsearch.c
> > @@ -40,7 +40,7 @@
> >   *       configuration according to the specified parameters.
> >   *   (3) User starts the search(es) by calling _find() or _next() to
> >   *       fetch subsequent occurrences. A state variable is provided
> > - *       to the algorihtm to store persistant variables.
> > + *       to the algorihtm to store persistent variables.
> 
> fix /algorithm/ while here?
> or did Matt already fix that one?
> 

I haven't yet submitted typo fixes to any c/h files, so no.  I actually do have a c/h file patch done and pending from a couple days ago, I just haven't mailed it yet.

> >   *   (4) Core eventually resets the search offset and forwards the find()
> >   *       request to the algorithm.
> >   *   (5) Algorithm calls get_next_block() provided by the user continously
> 
> ---
> ~Randy


-- 
Matt

