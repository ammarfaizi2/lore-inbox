Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310745AbSCMQ1N>; Wed, 13 Mar 2002 11:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310743AbSCMQ1E>; Wed, 13 Mar 2002 11:27:04 -0500
Received: from bitmover.com ([192.132.92.2]:65158 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310754AbSCMQ0v>;
	Wed, 13 Mar 2002 11:26:51 -0500
Date: Wed, 13 Mar 2002 08:26:47 -0800
From: Larry McVoy <lm@bitmover.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
        Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020313082647.Y23966@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
	Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
	jaharkes@cs.cmu.edu,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020312223738.GB29832@pimlott.ne.mediaone.net> <Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be> <20020313143720.GA32244@pimlott.ne.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020313143720.GA32244@pimlott.ne.mediaone.net>; from andrew@pimlott.ne.mediaone.net on Wed, Mar 13, 2002 at 09:37:20AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 09:37:20AM -0500, Andrew Pimlott wrote:
> On Wed, Mar 13, 2002 at 10:39:28AM +0100, Geert Uytterhoeven wrote:
> > On Tue, 12 Mar 2002, Andrew Pimlott wrote:
> > > This is misleading--Clearcase stores versions on top a normal
> > > filesystem (like most other RCS's), and all manipulation is entirely
> >                                                               ^^^^^^^^
> > > in user-space (over the network to server processes).  There only
> >   ^^^^^^^^^^^^^
> > > filesystem magic is that there are directories you cannot list (plus
> > > permission semantics are a little funny).
> > 
> > So what's that ClearCase file system driver doing in kernel space?
> 
> Just providing a convenient view on the repository.  The only write
> operation you can do through the filesystem is write to the checked
> out version.  Checkin, checkout, branch, label, create new
> file/directory, rename, link, chmod, etc are all user-space.
> 
> Also, you can use ClearCase without the filesystem (snapshot view)
> and get all the same functionality.

Are you sure about that?  Snapshots are just the cleartext files.  The
set of operations you can do with a disconnected snapshot is extremely
limited, last I checked all you could do was edit the files.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
