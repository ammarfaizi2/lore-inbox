Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276370AbRJCPWn>; Wed, 3 Oct 2001 11:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276377AbRJCPWe>; Wed, 3 Oct 2001 11:22:34 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:5649 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S276370AbRJCPWU>;
	Wed, 3 Oct 2001 11:22:20 -0400
Date: Wed, 3 Oct 2001 08:24:15 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Ulrich Drepper <drepper@cygnus.com>, Andi Kleen <ak@suse.de>,
        Alex Larsson <alexl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <m1k7yc3ky5.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.10.10110030822130.3933-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Oct 2001, Eric W. Biederman wrote:

> Ulrich Drepper <drepper@redhat.com> writes:
> 
> > Andi Kleen <ak@suse.de> writes:
> > 
> > > For stat is also requires a changed glibc ABI -- the glibc/2.4 stat64
> > 
> > Not only stat64, also plain stat.
> > 
> > > structure reserved an additional 4 bytes for every timestamp, but these
> > > either need to be used to give more seconds for the year 2038 problem
> > > or be used for the ms fractions. y2038 is somewhat important too.
> > 
> > The fields are meant for nanoseconds.  The y2038 will definitely be
> > solved by time-shifting or making time_t unsigned.  In any way nothing
> > of importance here and now.  Especially since there won't be many
> > systems which are running today and which have a 32-bit time_t be used
> > then.  For the rest I'm sure that in 37 years there will be the one or
> > the other ABI change.
> 
> Right.  Given current uptimes and being optimistic the fix for y2038 
> is probably needed by 2030 or just a little later.  But in any case
> 64 bit systems should be maxing out by then, and the conversion to 128
> bit systems should have already happened on the server side.  32 bit
> systems will likely be limited to embedded and legacy systems by then.
> 
> Eric

Why do I get the feeling no one has learned from the problems the computer
industry had with 2 digit date fields?

Odds are legacy systems will be running something people for whatever
reason couldn't replace.


	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

