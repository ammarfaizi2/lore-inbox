Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280976AbRLDQdf>; Tue, 4 Dec 2001 11:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278625AbRLDQdZ>; Tue, 4 Dec 2001 11:33:25 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62220 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S280961AbRLDQdN>; Tue, 4 Dec 2001 11:33:13 -0500
Date: Tue, 4 Dec 2001 17:33:09 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@caldera.de>, "Eric S. Raymond" <esr@thyrsus.com>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204173309.A10746@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@caldera.de>,
	"Eric S. Raymond" <esr@thyrsus.com>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011204142958.A14069@caldera.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2001, Christoph Hellwig wrote:

> On Tue, Dec 04, 2001 at 08:16:40AM -0500, Eric S. Raymond wrote:
> > N separate implementations means N dialects and N**2 compatibility problems.
> > Nicer just to have *one* parser, *one* compiler, and *one* service class that
> > supports several thin front-end layers, yes?  No?
> 
> Oh man.  When you think one implementation of a 'standard' is better then
> multiple go to the MS world.

Well, there is competition: CML2. It is setting a new standard, which
Microsoft only claim, but never achieve (except for standards of making
licensing more restrictive). >:-)

Seriously: what do you fear? Losing the efforts you put into mconfig?
Linux 2.2 and 2.4 will be around for quite some time (not sure about
mconfig on 2.0, I don't use 2.0.x ATM).

Creating a dependency on Python? Is a non-issue. Current systems that
are to run 2.5 or 2.6 are bloated beyond belief by glibc already, Python
is nice and it does not create such unmaintainable mess. Whether
Python's syntax is actually good is disbutable, but at no avail; it's
possible yet no good to discuss taste. In the end, you do not need to
maintain that code. You don't make the pen yourself when writing a
letter either.

> > I quote Linus at the 2.5 kernel summit: "Python is not an issue."
> > Unless and until he changes his mind about that, waving around this
> > kind of argument is likely to do your case more harm than good.
> 
> For me (and others) it is an issues.

What are the precise issues with Python? Just claiming it is an issue is
not useful for discussing this. Archive pointers are welcome.
