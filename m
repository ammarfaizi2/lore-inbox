Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWHQIqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWHQIqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHQIqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:46:49 -0400
Received: from 1wt.eu ([62.212.114.60]:2320 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S932354AbWHQIqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:46:48 -0400
Date: Thu, 17 Aug 2006 10:37:02 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060817083702.GB14673@1wt.eu>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155797331.4494.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On Thu, Aug 17, 2006 at 08:48:51AM +0200, Arjan van de Ven wrote:
> 
> > Right now, I'd prefer getting gcc 4 support than gcc 3.4, because I don't
> > know if even one common distro has shipped with gcc 3.4 by default. 2.95,
> > 3.0, and 3.3 have been common, and right now, 4.[01] is almost everywhere.
> 
> but most distros that ship with gcc 4 aren't capable of running a 2.4
> kernel.... all the new distros greatly depend on sysfs for example, and
> ntpl in glibc requires 2.6 etc etc etc. So I'm rather sceptical about
> this argument.

I know, and this is not what I'm targetting. People use 2.4 on their file
server or firewall for instance, on an old distro, while they use 2.6 on
their notebook with newer gcc. They build from their fresh new system
(because most often you don't install build tools on a server) and this
is at least why some of them have already been asking for this. To be honnest,
I don't really need gcc 4 myself right now, but I'm more responding to some
users demand that I find somewhat legitimate.

> > >   Since there shouldn't be any reason for still using a 2.4 kernel
> > >   except for "never change a running system",
> > 
> > I think that by "never change", you meant "except for regular updates".
> 
> I think that you'll find that people who run 2.4 today, if you ask them,
> will say "please change as little as possible, only serious bugs and
> security issues". After all the people who run 2.4 still are generally
> those who resist new stuff in favor of stability of existing systems....
> But maybe it's worth doing a user survey to find out what the users of
> 2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
> people who use enterprise distro kernels don't count for this since
> they'll not go to a newer released 2.4 anyway)

Agreed, that's also why I've left it in another tree right now, so that
interested people can test it and other ones have the time to pronounce
themselves against it if needed. Anyway, as I said, most of the fixes were
for real coding bugs, and do not affect either the output code nor external
patches. I don't want to experiment with new killer features at all, if I
accepted to work on 2.4, this is because I'm rather conservative ;-)

Cheers,
Willy

