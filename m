Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTLWROv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTLWROv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:14:51 -0500
Received: from havoc.gtf.org ([63.247.75.124]:18380 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261807AbTLWROt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:14:49 -0500
Date: Tue, 23 Dec 2003 12:14:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Christophe Saout <christophe@saout.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031223171449.GA8847@gtf.org>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <20031223131355.A6864@infradead.org> <1072186582.4111.46.camel@leto.cs.pocnet.net> <20031223151545.GE476@reti> <20031223153143.GA28690@gtf.org> <20031223154325.GF476@reti> <20031223170118.GA4384@leto.cs.pocnet.net> <20031223171541.GG476@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223171541.GG476@reti>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 05:15:41PM +0000, Joe Thornber wrote:
> On Tue, Dec 23, 2003 at 06:01:18PM +0100, Christophe Saout wrote:
> > So how does this look?
> 
> <snip>
> 
> > -static struct dm_daemon _kcryptd;
> > +static struct dm_daemon kcryptd;
> 
> Please keep the leading underscore, it indicates that it is static
> data; a convention that is used throughout dm.  hch was ok about it
> last time he noticed it, so he can't really complain now ;)

ewwww...  The programmer knows what is static data without needing a
leading underscore.

This practice is wrong for the same reason that Hungarian notation is
wrong :)

	Jeff



