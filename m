Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132889AbRDQVxh>; Tue, 17 Apr 2001 17:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132890AbRDQVxL>; Tue, 17 Apr 2001 17:53:11 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23380 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132889AbRDQVwH>; Tue, 17 Apr 2001 17:52:07 -0400
Date: Wed, 18 Apr 2001 00:06:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org, dhowells@astarte.free-online.co.uk
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Message-ID: <20010418000658.F31982@athlon.random>
In-Reply-To: <20010417224933.E31982@athlon.random> <200104172129.XAA14514@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104172129.XAA14514@ns.caldera.de>; from hch@caldera.de on Tue, Apr 17, 2001 at 11:29:23PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 11:29:23PM +0200, Christoph Hellwig wrote:
> Yes! All the objects in export-objs only get additional depencies in
> Rules.make - but if they do not get compiled at all that depencies won't
> matter either.  All other makefile work this way, btw.

ok thanks for the confirm.

> In my first mail I forgot that the makefile can be optimized even
> further, the hunk should look like this:

Yes, I didn't used the -$() form only because I thought I had to make
conditional the export-objs too.

I applied it.

Andrea
