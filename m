Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbTLWPH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265160AbTLWPH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:07:58 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:10256 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265158AbTLWPH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:07:57 -0500
Date: Tue, 23 Dec 2003 15:10:43 +0000
From: Joe Thornber <thornber@sistina.com>
To: Christoph Hellwig <hch@infradead.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 1/2] Add dm-daemon
Message-ID: <20031223151043.GD476@reti>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222214952.GA13103@leto.cs.pocnet.net> <20031223122751.A6498@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223122751.A6498@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 12:27:51PM +0000, Christoph Hellwig wrote:
> On Mon, Dec 22, 2003 at 10:49:52PM +0100, Christophe Saout wrote:
> > Hi.
> > 
> > The first patch adds dm-daemon.c/.h.
> > 
> > The code is from Joe Thornbers current unstable device-mapper patchset.
> 
> This should really be in generic code, not in DM.  I remember I did
> something similar as kthread abstraction a while ago, but it didn't head
> anywhere..

Agreed, but lets put it into drivers/md to start with and move it
later when it matures.  There are still a couple of interface changes
I want to make, and I'm not yet convinced that I've got it yielding
enough on 2.6.

- Joe
