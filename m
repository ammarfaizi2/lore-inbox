Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTLWPNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTLWPNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:13:05 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:27909 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S261188AbTLWPM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:12:59 -0500
Date: Tue, 23 Dec 2003 15:15:45 +0000
From: Joe Thornber <thornber@sistina.com>
To: Christophe Saout <christophe@saout.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031223151545.GE476@reti>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <20031223131355.A6864@infradead.org> <1072186582.4111.46.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072186582.4111.46.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 02:36:22PM +0100, Christophe Saout wrote:
> Am Di, den 23.12.2003 schrieb Christoph Hellwig um 14:13:
> 
> > Please include driver-private headers after kernel headers.

I tend to do things this way round to ensure that the private headers
have correctly included all that they need, rather than relying on the
accidental inclusion of a standard header.

> > > +static struct dm_daemon _kcryptd;
> > 
> > Again, rather strange naming..
> 
> This was done to be consistent with the other device-mapper code. I can
> change it though.

Kernel CRYPT Daemon

In the same way we have a kmirrord, kcopyd etc.  I'm happy with the
name.

- Joe
