Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318313AbSHPLZt>; Fri, 16 Aug 2002 07:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318312AbSHPLZt>; Fri, 16 Aug 2002 07:25:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:11140 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318313AbSHPLZs>; Fri, 16 Aug 2002 07:25:48 -0400
Date: Fri, 16 Aug 2002 16:58:31 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816165831.A2104@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com> <20020816100334.GP14394@dualathlon.random> <20020816165306.A2055@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020816165306.A2055@in.ibm.com>; from suparna@in.ibm.com on Fri, Aug 16, 2002 at 04:53:06PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 04:53:06PM +0530, Suparna Bhattacharya wrote:
> On Fri, Aug 16, 2002 at 12:03:34PM +0200, Andrea Arcangeli wrote:
> > On Fri, Aug 16, 2002 at 03:09:46PM +0530, Suparna Bhattacharya wrote:
> > > Also, wasn't the fact that the API was designed to support both POSIX 
> > > and completion port style semantics, another reason for a different 
> > > (lightweight) in-kernel api? The c10k users of aio are likely to find 
> > > the latter model (i.e.  completion ports) more efficient.
> > 
> > if it's handy for you, can you post a link to the API defined by
> > POSIX and completion ports so I can read them too and not only SuS?
> 
> Don't have anything handy atm that's any better than what you could 
> get through doing a google on "IO Completion ports". (See section at
> the end of this note for some info)

Oh sorry, I should have mentioned Dan Kegel's site which actually
has all the pointers you need. See http://www.kegel.com/c10k.html
(It has pointers to links to both NT and OS/400 completion ports)

Regards
Suparna
