Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263233AbTCNDgF>; Thu, 13 Mar 2003 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbTCNDgF>; Thu, 13 Mar 2003 22:36:05 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:9601 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263233AbTCNDgE>; Thu, 13 Mar 2003 22:36:04 -0500
Subject: Re: 2.5.64-mm6
From: Shawn <core@enodev.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Steven Cole <elenstev@mesatop.com>, jeremy@goop.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030313192809.17301709.akpm@digeo.com>
References: <20030313032615.7ca491d6.akpm@digeo.com>
	 <1047572586.1281.1.camel@ixodes.goop.org>
	 <20030313113448.595c6119.akpm@digeo.com>
	 <1047611104.14782.5410.camel@spc1.mesatop.com>
	 <20030313192809.17301709.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047613609.2848.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 21:46:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 21:28, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > On Thu, 2003-03-13 at 12:34, Andrew Morton wrote:
> > > Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> > > >
> > > > On Thu, 2003-03-13 at 03:26, Andrew Morton wrote:
> > > > >   This means that when an executable is first mapped in, the kernel will
> > > > >   slurp the whole thing off disk in one hit.  Some IO changes were made to
> > > > >   speed this up.
> > > > 
> > > > Does this just pull in text and data, or will it pull any debug sections
> > > > too?  That could fill memory with a lot of useless junk.
> > > > 
> > > 
> > > Just text, I expect.  Unless glibc is mapping debug info with PROT_EXEC ;)
> > > 
> > > It's just a fun hack.  Should be done in glibc.
> > 
> > Well, fun hack or glibc to-do list candidate, I hope it doesn't get
> > forgotten.
> 
> I have to pull the odd party trick to get people to test -mm kernels.

This reminds me of something I've not looked into for some time.

Being an active user of the 2.5 series including -mm, should I have
updated glibc, or is there nothing new enough yet to warrant that?

Maybe I should just ask the glibc people. Wasn't sure what the proper
forum was.
