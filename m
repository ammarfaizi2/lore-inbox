Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbSJMVQb>; Sun, 13 Oct 2002 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261746AbSJMVQa>; Sun, 13 Oct 2002 17:16:30 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:58130 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261562AbSJMVQa>;
	Sun, 13 Oct 2002 17:16:30 -0400
Date: Sun, 13 Oct 2002 14:17:40 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <20021013211740.GC24140@kroah.com>
References: <39770000.1034541701@flay> <20021013205933.GA24140@kroah.com> <48100000.1034543175@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48100000.1034543175@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 02:06:15PM -0700, Martin J. Bligh wrote:
> >> I will invest some serious effort and time in cleanup after the feature freeze,
> >> including investigating using the subarch support which I know some people
> >> would like to see done.
> > 
> > Any reason why most of these changes couldn't be moved to the subarch
> > code now?
> 
> 1. Time
> 2. It'd make the patches much bigger and harder to read.
> 
> I *will* do that. Just not in time for the freeze. IMHO, that's a cleanup (and yes,
> a needed one).

Hm, IMVHO I think this should be done correctly, as a subarch, instead
of just patches (although your patches are split up very nicely, good
job, that couldn't have been very easy.)  I don't know if "Time" is a
good excuse to put things like this in the tree, in the format that it
shouldn't be.

But as I'm not the i386 maintainer, I'll let Linus decide that one :)

thanks,

greg k-h
