Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUAMKvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbUAMKvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:51:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28132 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263946AbUAMKvf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:51:35 -0500
Date: Tue, 13 Jan 2004 10:51:33 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Adrian Bunk <bunk@fs.tum.de>, Andreas Haumer <andreas@xss.co.at>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] disallow modular CONFIG_COMX
Message-ID: <20040113105133.GB21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at> <20040111013043.GY25089@fs.tum.de> <40031EB1.5030705@pobox.com> <20040113095711.A15396@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113095711.A15396@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 09:57:11AM +0000, Christoph Hellwig wrote:
> On Mon, Jan 12, 2004 at 05:24:49PM -0500, Jeff Garzik wrote:
> > I agree with the intent...
> > 
> > At this point, I am tempted to simply comment it out of the Config.in, 
> > and let interested parties backport bug fixes and crap from 2.6 if they 
> > would like.  The driver has had obvious bugs for a while...
> 
> In 2.6 it's as buggy as in 2.4..

The driver is full of obvious bugs, had been that way for years, has
userland API broken by design and maintainers who couldn't be arsed
to fix it.

By now I don't see how anything short of rm(1) will help that animal.
