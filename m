Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310497AbSCGULJ>; Thu, 7 Mar 2002 15:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310499AbSCGUK7>; Thu, 7 Mar 2002 15:10:59 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33296 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310497AbSCGUKs>;
	Thu, 7 Mar 2002 15:10:48 -0500
Date: Thu, 7 Mar 2002 17:10:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <yodaiken@fsmlabs.com>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87BD22.BBBF4A86@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203071709400.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Andrew Morton wrote:
> Daniel Phillips wrote:
> >
> > a GFP flag that says 'fail if this looks hard to get'.
>
> Something like that would provide a solution to the
> readahead thrashing problem.

Nope.  Readahead pages are clean and very easy to evict, so
it's still trivial to evict all the pages from another readahead
window because everybody's readahead window is too large.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

