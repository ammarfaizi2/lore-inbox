Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbTIBSgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTIBSgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:36:43 -0400
Received: from rubicon.hasler.ascom.ch ([139.79.129.1]:55448 "EHLO
	rubicon.hasler.ascom.ch") by vger.kernel.org with ESMTP
	id S261243AbTIBSgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:36:40 -0400
Date: Tue, 2 Sep 2003 20:35:54 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
To: Christoph Hellwig <hch@infradead.org>, Andrew Lunn <andrew.lunn@ascom.ch>,
       Andrew Morton <akpm@osdl.org>, andrew@lunn.ch,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-ID: <20030902183554.GC6652@biferten.ma.tech.ascom.ch>
References: <20030902104212.GA23978@londo.lunn.ch> <20030902150808.A7388@infradead.org> <20030902102141.44dc7297.akpm@osdl.org> <20030902184236.A14715@infradead.org> <20030902104340.1e360f1b.akpm@osdl.org> <20030902190258.A15601@infradead.org> <20030902181654.GB6652@biferten.ma.tech.ascom.ch> <20030902192928.A17371@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902192928.A17371@infradead.org>
User-Agent: Mutt/1.4i
X-Filter-Version: 1.11a (rubicon)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 07:29:29PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 02, 2003 at 08:16:54PM +0200, Andrew Lunn wrote:
> > > That's why I'm really keen on knowing how the system of the bugreporter
> > > looks - this shouldn't happen without a very strange setup.
> > 
> > I've attached to the bugzilla bug my .config (its actually for -test2)
> > and an ls -la /dev/pt*
> > 
> > Is there anything else you want to know?
> 
> That doesn't really help - if an application opens old-style pty's
> directly the permissions can't work.  IF you care for them fill a
> bugreport to ripperx that it should use openpty() from libc which
> will fix the problem automatically.

OK. Will do.

> I was just wondering whether you were using an acient / stripped
> down libc with the pt_chown helper removed.

Nope. A pritty normal Debian Woody system.

      Thanks
        Andrew
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 07:29:29PM +0100, Christoph Hellwig wrote:
> On Tue, Sep 02, 2003 at 08:16:54PM +0200, Andrew Lunn wrote:
> > > That's why I'm really keen on knowing how the system of the bugreporter
> > > looks - this shouldn't happen without a very strange setup.
> > 
> > I've attached to the bugzilla bug my .config (its actually for -test2)
> > and an ls -la /dev/pt*
> > 
> > Is there anything else you want to know?
> 
> That doesn't really help - if an application opens old-style pty's
> directly the permissions can't work.  IF you care for them fill a
> bugreport to ripperx that it should use openpty() from libc which
> will fix the problem automatically.

OK. Will do.

> I was just wondering whether you were using an acient / stripped
> down libc with the pt_chown helper removed.

Nope. A pritty normal Debian Woody system.

      Thanks
        Andrew
