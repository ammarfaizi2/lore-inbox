Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTFJRll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTFJRll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:41:41 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:9863 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263759AbTFJRlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:41:40 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: corbet@lwn.net (Jonathan Corbet), "Lars Unin" <lars_unin@linuxmail.org>
Subject: LKML FAQ updating (was: Re: kernel spinlocks; when to use; when appropriate?)
Date: Tue, 10 Jun 2003 13:57:30 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
References: <20030609155051.22121.qmail@eklektix.com>
In-Reply-To: <20030609155051.22121.qmail@eklektix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306101357.30908.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, that link needs to go in the "basic linux kernel documentation" section 
at the start of the "http://www.tux.org/lkml/" faq, along with some other 
resources that have fallen through the cracks.  I'd happily generate a patch 
against the FAQ, but haven't a clue what the source format is.  (Is it 
hand-hacked HTML?)

Documentation resources:

Linux Device Drivers, second edition (whole book online).
http://www.xml.com/ldd/chapter/book/index.html

Porting device drivers to 2.5 (30-article series):
http://lwn.net/Articles/driver-porting/

Linux Kernel Internals (walkthrough of kernel 2.4 source):
http://www.moses.uklinux.net/patches/lki.html

Mel Gorman's Virtual Memory Guides (read "understanding" first, then 
"coding"):
http://www.csn.ul.ie/~mel/projects/vm/guide/

Also, the "asking smart questions" thing isn't on tuxedo.org anymore, it's on 
catb.org.  (Otherwise same URL.)

And while we're on the subject, could the mention of the Documentation 
directory in the linux kernel source A) be moved to the start of the list, B) 
be updated to include a mention of "make htmldocs" and friends?

I'm sure there's more, this is just off the top of my head.  I'd be happy to 
whip up a patch if I had a clue what file it should be against...

Rob

On Monday 09 June 2003 11:50, Jonathan Corbet wrote:
> >    When is is appropriate to use spinlocks in the kernel,
> > how are they implemented (e.g. syntax, function names) and
> > can anyone think of a good area of the kernel for me to look
> > at, that uses them?
>
> May I humbly suggest a look at Linux Device Drivers, Second Edition?  It
> goes over locking primitives in a fair amount of detail, and includes
> examples of their use.  Available freely online at:
>
> 	http://www.xml.com/ldd/chapter/book/index.html
>
> or in your favorite bookstore.
>
> jon
>
> Jonathan Corbet
> Executive editor, LWN.net
> corbet@lwn.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

