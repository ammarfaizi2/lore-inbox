Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132890AbRDUU3i>; Sat, 21 Apr 2001 16:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132900AbRDUU32>; Sat, 21 Apr 2001 16:29:28 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:15123 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132890AbRDUU3M>;
	Sat, 21 Apr 2001 16:29:12 -0400
Date: Sat, 21 Apr 2001 16:29:47 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010421162947.A4490@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010421114942.A26415@thyrsus.com> <200104212023.f3LKN7P188973@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104212023.f3LKN7P188973@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sat, Apr 21, 2001 at 04:23:06PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan <acahalan@cs.uml.edu>:
> Eric S. Raymond writes:
> 
> > This is a proposal for an attribution metadata system in the Linux
> > kernel sources.  The goal of the system is to make it easy for
> > people reading any given piece of code to identify the responsible
> > maintainer.  The motivation for this proposal is that the present
> > system, a single top-level MAINTAINERS file, doesn't seem to be
> > scaling well.
> 
> It is nice to have a single file for grep. With the proposed
> changes one would sometimes need to grep every file.

The right way to handle that is to have a report generator that does the
grep for you, or if you like simply returns the concatenation of all the
map blocks so you can grep that.

The point of distributing them is so they're close to the work units they
describe, and are thus (a) easy to find, and (b) more likely to stay up to
date.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never could an increase of comfort or security be a sufficient good to be
bought at the price of liberty.
	-- Hillaire Belloc
