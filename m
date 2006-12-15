Return-Path: <linux-kernel-owner+w=401wt.eu-S1753334AbWLOU2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbWLOU2w (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753339AbWLOU2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:28:52 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:39447 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753334AbWLOU2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:28:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH/v2] CodingStyle updates
Date: Fri, 15 Dec 2006 21:30:59 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215150717.GA2345@elf.ucw.cz> <20061215090037.05c021af.randy.dunlap@oracle.com>
In-Reply-To: <20061215090037.05c021af.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612152130.59848.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 15 December 2006 18:00, Randy Dunlap wrote:
> On Fri, 15 Dec 2006 16:07:17 +0100 Pavel Machek wrote:
> 
> > On Fri 2006-12-15 08:52:22, Scott Preece wrote:
> > > On 12/15/06, Pavel Machek <pavel@ucw.cz> wrote:
> > > >Hi!
> > > >
> > > >> Pavel Machek wrote:
> > > >> >> From: Randy Dunlap <randy.dunlap@oracle.com>
> > > >> >> +Use one space around (on each side of) most binary and ternary 
> > > >operators,
> > > >> >> +such as any of these:
> > > >> >> +  =  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
> > > >> >
> > > >> > Actually, this should not be hard rule. We want to allow
> > > >> >
> > > >> >     j = 3*i + l<<2;
> > > >>
> > > >> Which would be very misleading. This expression evaluates to
> > > >>
> > > >>       j = (((3 * i) + l) << 2);
> > > >>
> > > >> Binary + precedes <<.
> > > >
> > > >Aha, okay. So this one should be written as
> > > >
> > > >        j = 3*i+l << 2;
> > > >
> > > >(Well, parenthesses should really be used. Anyway, sometimes grouping
> > > >around operator is useful, even if I made mistake demonstrating that.
> > > ---
> > > 
> > > I think the mistake illuminates why parentheses should be the rule. If
> > > you're thinking about using spacing to convey grouping, use
> > > parentheses instead...
> > 
> > Not in simple cases.
> > 
> > 	3*i + 2*j should be writen like that. Not like
> > 	(3 * i) + (2 * j)
> 
> I would just write it as:
> 	3 * i + 2 * j

\metoo
