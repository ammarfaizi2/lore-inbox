Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVAMUrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVAMUrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVAMUrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:47:47 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26085 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261683AbVAMUpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:45:54 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: grendel@caudium.net
Cc: Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113202905.GD24970@beowulf.thanes.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113194246.GC24970@beowulf.thanes.org>
	 <20050113115004.Z24171@build.pdx.osdl.net>
	 <20050113202905.GD24970@beowulf.thanes.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105645267.4644.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 19:41:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 20:29, Marek Habersack wrote:
> I understand that, but I don't see a point in holding the fixes back for the
> majority of people (since the vendors on vendor-sec are a minority and I

vendor-sec probably covers the majority of users

It covers
	2.4
	2.6-ac
	Red Hat
	SuSE
	Debian
	Gentoo
	Mandrake
	and many more including some of the BSD folk (a lot of user space bugs
are common)

2.6 base isn't covered because Linus has differing views.

> suspect that more people run self-compiled kernels on their servers than the
> vendor kernels, I might be wrong on that). If there is a list that's at

I'd say you are very very wrong from the data I have access too,
probably of the order of 1000:1 wrong or more.

> > Licensing is irrelevant.  Like it or not, the person who is discovering
> > the bugs has some say in how you deal with the information.  It's in our
> > best interest to work nicely with these folks, not marginalize them.

> It's not about marginalizing, because by requesting that their report is
> kept secret for a while and known only to a small bunch of people, you could
> say they are marginalizing us, the majority of people who use the linux
> kernel (us - those who aren't on the vendor-sec list). It's, again IMHO,

They chose to. A lot of people report bugs directly to Linus too or to
the lists or to full-disclosure depending upon their view. The folks who
report bugs in private either to Linus or to vendor-sec or maintainers
or whoever generally believe that the bad guys can move faster and cause
a lot of damage if a bug isn't fixed before announce.

Thats based on the observation that
	- the bad guys have to move a small exploit versus a large binary
	- the exploit doesn't have to pass quality assurance, you just write
more
	- they can automate the attack tools very effectively 

So the non-disclosure argument is perhaps put as "equality of access at
the point of discovery means everyone gets rooted.". And if you want a
lot more detail on this read papers on the models of security economics
- its a well studied field.

Alan

