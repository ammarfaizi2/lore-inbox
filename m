Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310787AbSCMQtD>; Wed, 13 Mar 2002 11:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310795AbSCMQsy>; Wed, 13 Mar 2002 11:48:54 -0500
Received: from chmls20.ne.ipsvc.net ([24.147.1.156]:56214 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S310787AbSCMQsj>; Wed, 13 Mar 2002 11:48:39 -0500
Date: Wed, 13 Mar 2002 11:30:45 -0500
To: Larry McVoy <lm@work.bitmover.com>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
        Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
        jaharkes@cs.cmu.edu,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020313163045.GA6575@pimlott.ne.mediaone.net>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Hans Reiser <reiser@namesys.com>, James Antill <james@and.org>,
	Larry McVoy <lm@bitmover.com>, Tom Lord <lord@regexps.com>,
	jaharkes@cs.cmu.edu,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020312223738.GB29832@pimlott.ne.mediaone.net> <Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be> <20020313143720.GA32244@pimlott.ne.mediaone.net> <20020313082647.Y23966@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313082647.Y23966@work.bitmover.com>
User-Agent: Mutt/1.3.27i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 08:26:47AM -0800, Larry McVoy wrote:
> On Wed, Mar 13, 2002 at 09:37:20AM -0500, Andrew Pimlott wrote:
> > Also, you can use ClearCase without the filesystem (snapshot view)
> > and get all the same functionality.
> 
> Are you sure about that?  Snapshots are just the cleartext files.  The
> set of operations you can do with a disconnected snapshot is extremely
> limited, last I checked all you could do was edit the files.

Right, if you're disconnected from the network, that's all you can
do (and it sucks, because if you haven't already checked out the
file you want to edit, you have to "hijack" it, and clearcase deals
with hijacks in a braid-dead way).

But if you're on the network, you can use a snapshot view in the
same way as a dynamic view.  You just don't get a "real-time" view
of the repository and the magic foo.c@@/ directories.  (It has the
advantages that you can take it off the network and still have some
limited functionality; it's faster; and you don't have to run an old
Linux kernel and binary modules.)

So to be clear, I was definitely talking about using a snapshot view
while connected to the clearcase servers.  In this case, you can do
everything you could do in a dynamic view.

Andrew
