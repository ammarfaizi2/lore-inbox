Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315584AbSECHOB>; Fri, 3 May 2002 03:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315585AbSECHOA>; Fri, 3 May 2002 03:14:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9002 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315584AbSECHN7>; Fri, 3 May 2002 03:13:59 -0400
Date: Fri, 3 May 2002 09:14:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre7aa3
Message-ID: <20020503091445.E11414@dualathlon.random>
In-Reply-To: <20020430203154.B11414@dualathlon.random> <20020430202010.A16236@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 08:20:10PM +0100, Christoph Hellwig wrote:
> On Tue, Apr 30, 2002 at 08:31:54PM +0200, Andrea Arcangeli wrote:
> > Only in 2.4.19pre7aa3: 00_wake_up_page-1
> > 
> > 	Reintroduced wake_up_page (not deadlock prone anymore), for modules
> > 	that were waking up pages.
> 
> For what module?  (Don't say a agp/drm upgrade!)  As the person who invented

that's a drm upgrade indeed.

> wake_up_page I can't really see a good reason for it anymore.  Every single
> caller should have used unlock_page() instead.

Agreed, thanks for noticing.

Andrea
