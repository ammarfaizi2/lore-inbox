Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310453AbSCGTHB>; Thu, 7 Mar 2002 14:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310459AbSCGTGw>; Thu, 7 Mar 2002 14:06:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20384 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310453AbSCGTGl>;
	Thu, 7 Mar 2002 14:06:41 -0500
Date: Thu, 7 Mar 2002 14:06:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ed Vance <EdV@macrolink.com>
cc: "'Jean-Luc Leger'" <reiga@dspnet.fr.eu.org>, linux-kernel@vger.kernel.org
Subject: RE: Petition Against Official Endorsement of BitKeeper by Linux M
 aintainers
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A76E0@EXCHANGE>
Message-ID: <Pine.GSO.4.21.0203071402472.26116-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Mar 2002, Ed Vance wrote:

> On Thu, Mar 07, 2002 at 10:03 AM, Jean-Luc Leger wrote:
> > > Larry McVoy <lm@bitmover.com> writes:
> > > >	bk prs -hrv2.5.0.. |  while read x
> > 
> > by the way, shouldn't it be "$x" in the second line ?
> > or am I missing something ?
> > 
> > 	JL
> 
> man bash
> ...
>     read  [-ers]  [-t  timeout]  [-a  aname]  [-p  prompt] [-n
>           nchars] [-d delim] [name ...] 
>                               ^^^^
> Nope, no "$" on the variable name in this context. The reference 
> is to the variable's identifier rather than its value.

He said _second_ line.  Larry got $i there.  In any case, for that
one
bk prs -hrv2.5.0.. | sed -e "s!.*!<body of the loop>!" | sh
would be simpler and more compact (with & instead of $i).
He doesn't have metacharcters in there, so it's safe...

