Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTKNQYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKNQYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:24:35 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:25245 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S262766AbTKNQYe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:24:34 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: kernel.bkbits.net off the air
Date: Fri, 14 Nov 2003 16:24:31 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311132057.53026.andrew@walrond.org> <20031114150047.GC30711@work.bitmover.com>
In-Reply-To: <20031114150047.GC30711@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141624.32108.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 Nov 2003 3:00 pm, Larry McVoy wrote:
> On Thu, Nov 13, 2003 at 08:57:53PM +0000, Andrew Walrond wrote:
> > The point. You got one major o/s project hosted on bk when you ought to
> > have them all. Loads more developers using bk at home means loads more
> > demanding it at work.
> >
> > And all it would take is a lobotomised, redistributable, license free
> > client so anyone can pull o/s software from bk repos.
>
> One of us is not getting it, maybe it's me.  To build something like
> you describe is pretty easy IF AND ONLY IF all you are asking for is an
> update mechanism.  As soon as you want revision history, diffs, rollbacks,
> modifiable files, etc., you have to go to real BK.  Is that OK?  All you
> want is a "keep me up to date" mechanism?  No diffs, no history, it's a
> replacement for tarballs and patches?

Yes exactly. Fundamentally I want *anybody*, without restriction, to ge able 
to pull and update sources from any open-source project hosted with bk.

The requirements are the equivalent functionality to:

lobobk clone ...
lobobk -r co
lobobk pull
lobobk export -r tag dest

Ie, Get a local clone of the repo, Be able to keep it updated, checkout the 
head version and export any particular tagged version.

and absolutely nothing else.

Not necessary, but if the cloned repo  was complete enough to be recloned, It 
would also make the perfect tool for anyone wanting to host a coherent mirror 
of the repo. Which takes us full circle I believe :)

Andrew Walrond

