Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTFDKez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFDKey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:34:54 -0400
Received: from ns.suse.de ([213.95.15.193]:16391 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263185AbTFDKew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:34:52 -0400
Date: Wed, 4 Jun 2003 12:48:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Message-ID: <20030604104825.GR3412@x30.school.suse.de>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306041246.21636.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:46:33PM +0200, Marc-Christian Petersen wrote:
> On Wednesday 04 June 2003 12:42, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > > > the issue with batching in 2.4, is that it is blocking at 0 and waking
> > > > at batch_requests. But it's not blocking new get_request to eat
> > > > requests in the way back from 0 to batch_requests. I mean, there are
> > > > two directions, when we move from batch_requests to 0 get_requests
> > > > should return requests. in the way back from 0 to batch_requests the
> > > > get_request should block (and it doesn't in 2.4, that is the problem)
> > > do you see a chance to fix this up in 2.4?
> > Nick posted a patch to do so the other day and asked people to test.
> Silly mcp. His mail was CC'ed to me :( ... F*ck huge inbox.

I was probably not CC'ed, I'll search for the email (and I was
travelling the last few days so I didn't read every single l-k email yet
sorry ;)

Andrea
