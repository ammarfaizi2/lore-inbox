Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262519AbTCIOjT>; Sun, 9 Mar 2003 09:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262520AbTCIOjT>; Sun, 9 Mar 2003 09:39:19 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:51214 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id <S262519AbTCIOjR>;
	Sun, 9 Mar 2003 09:39:17 -0500
Date: Sun, 9 Mar 2003 15:49:55 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030309144954.GA66265@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303090401160.32518-100000@serv> <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303081936400.27974-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 07:42:24PM -0800, Linus Torvalds wrote:
> 
> On Sun, 9 Mar 2003, Roman Zippel wrote:
> > On Sat, 8 Mar 2003, Zack Brown wrote:
> > 
> > >   * Distributed rename handling.
> > 
> > This actually a very bk specific problem, because the real problem under 
> > bk there can be only one src/SCCS/s.foo.c.
> 
> I don't think that is the issue.
> 
> [ Well, yes, I agree that the SCCS format is bad, but for other reasons ]

It is a large part of the issue though.  If you don't have one
repository file per project file with a name that resembles the
repository's one you find out that the project file name is somewhat
unimportant, just yet another of the metadata to track.


> The problem is _distribution_.

The only problem with distribution is sending as little as possible
over the network.  All the problems you're talking about exist with a
single repository as soon as you have decent branches.


> In other words, two people rename the same 
> file. Or two people rename two _different_ files to the same name. Or two 
> people create two different files with the same name. What happens when 
> you merge?

A conflict, what else?  The file name is only one of the
characteristics of a file.  And BTW, the interesting problem which is
what to do when you find out two different files end up being in fact
the same one is not covered by bk (or wasn't).

  OG.
