Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbTIPRPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTIPRO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:14:29 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41189 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262000AbTIPROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:14:17 -0400
Date: Tue, 16 Sep 2003 19:10:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030916171057.GA8210@openzaurus.ucw.cz>
References: <20030916102113.0f00d7e9.skraw@ithnet.com> <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet> <20030916153658.3081af6c.skraw@ithnet.com> <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I do understand the bounce buffer problem, but honestly the current way
> > of handling the situation seems questionable at least. If you ever tried such a
> > system you notice it is a lot worse than just dumping the additional ram above
> > 4GB. You can really watch your network connections go bogus which is just
> > unacceptable. Is there any thinkable way to ommit the bounce buffers and still
> > do something useful with the beyond-4GB ram parts?
> 
> The 2.6 tree is somewhat better about this but at the end of the day if
> your I/O subsystem can't do the job your box will not perform ideally.
> For some workloads its a huge win to have the extra RAM, for others the
> I/O is a real pain. 

If he has trouble logging in, then there's a bug somewhere.
Bounce buffers should not slow machine down more than
2x, and from his description it looks like way worse slowdown. 
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

