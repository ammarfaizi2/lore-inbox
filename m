Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316227AbSEQOB1>; Fri, 17 May 2002 10:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316228AbSEQOB0>; Fri, 17 May 2002 10:01:26 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:48909 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S316227AbSEQOBY>;
	Fri, 17 May 2002 10:01:24 -0400
Date: Fri, 17 May 2002 15:01:18 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Page replacement documentation
In-Reply-To: <E178h81-0006OV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205171457580.6514-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Alan Cox wrote:

> > +     ----------------------------------------------------------------------
> > +
> > +     This document was translated from LATEX by HEVEA.
>
> If you switched it into DocBook format then the kernel shipped tools
> will generate a document from it including html/pdf/ps etc as well as
> being able to embed stuff
>

I'll look into it. I find DocBook very verbose to write in at the moment
and much prefer LaTeX but I'm guessing I won't have a lot of choice in the
matter when I release the rest of the documentation if anyone else is
going to build on it.

> > +/*
> > + * shink_cache - Shrinks buffer caches in a zone
> > + * nr_pages: Helps determine if process information needs to be sweapped
>
> You've not tested these. They should start
>

In this case, it was deliberate. I didn't want shrink_cache to be
advertised on the kernel-doc because it's not a function people outside of
vmscan.c should be calling so did not see the point in having it picked
up.

-- 
			Mel Gorman

