Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267477AbSLLUU1>; Thu, 12 Dec 2002 15:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbSLLUU1>; Thu, 12 Dec 2002 15:20:27 -0500
Received: from mark.mielke.cc ([216.209.85.42]:39180 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267477AbSLLUU0>;
	Thu, 12 Dec 2002 15:20:26 -0500
Date: Thu, 12 Dec 2002 15:36:46 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021212203646.GA14228@mark.mielke.cc>
References: <1039610907.25187.190.camel@pc-16.office.scali.no> <3DF78911.5090107@zytor.com> <1039686176.25186.195.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039686176.25186.195.camel@pc-16.office.scali.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 10:42:56AM +0100, Terje Eggestad wrote:
> On ons, 2002-12-11 at 19:50, H. Peter Anvin wrote:
> > Terje Eggestad wrote:
> > > PS:  rdtsc on P4 is also painfully slow!!!
> > Now that's just braindead...
> It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.
> For a simple op like that, even 11 is a lot... Really makes you wonder.

Some of this discussion is a little bit unfair. My understanding of what
Intel has done with the P4, is create an architecture that allows for
higher clock rates. Sure the P4 might take 84, vs PII 34, but how many
PII 2.4 Ghz machines have you ever seen on the market?

Certainly, some of their decisions seem to be a little odd on the surface.

That doesn't mean the situation is black and white.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

