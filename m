Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279081AbRJZTv0>; Fri, 26 Oct 2001 15:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRJZTvQ>; Fri, 26 Oct 2001 15:51:16 -0400
Received: from harddata.com ([216.123.194.198]:30724 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S279081AbRJZTvD>;
	Fri, 26 Oct 2001 15:51:03 -0400
Date: Fri, 26 Oct 2001 13:51:37 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: issue: deleting one IP alias deletes all
Message-ID: <20011026135137.A11455@mail.harddata.com>
In-Reply-To: <3BD5AED6.90401C9C@sun.com> <Pine.LNX.4.31.0110251121490.31833-100000@netmonster.pakint.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0110251121490.31833-100000@netmonster.pakint.net>; from mgm@paktronix.com on Thu, Oct 25, 2001 at 11:30:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 11:30:13AM -0500, Matthew G. Marsh wrote:
> On Tue, 23 Oct 2001, Tim Hockin wrote:
> 
> > Can anyone fill me in?
> 
> RPDB documentation is your freind.

The main problem with this documentation is that, wherever I have
seen it, it comes _only_ as few sizeable Postscript files.  Like
this (after 'ls -s' so sizes are in kilobytes):

 120 /usr/share/doc/iproute-2.2.4/api-ip6-flowlabels.ps
 336 /usr/share/doc/iproute-2.2.4/ip-cref.ps
 124 /usr/share/doc/iproute-2.2.4/ip-tunnels.ps

Mighty helpful if you happen to have only a text interface as is often
the case when you work on more complicated routing setups.  It is also
excellent for grepping (NOT!) through a 60 pages long document if you
want to find something on a particular topic.  Unfortunately it was not
apparently written in 'texinfo', or similar, as then one would have also
_at least_ .info files and an easy way to search through the whole thing
does not matter what kind of a display you have.

HTML format would be of some help but searches through that, especially
if multiple files are involved, are also not that nice.  Right now your
best bet is probably to print that out and carry a stack of papers with
you wherever you may need it.  Other than that you are currently reduced
to '/sbin/ip help' although you may follow up with something like
'/sbin/ip addr help' and you will get something to parse. :-)

  Michal
