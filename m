Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTFDKdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTFDKdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:33:16 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:8714 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263183AbTFDKdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:33:15 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Date: Wed, 4 Jun 2003 12:46:33 +0200
User-Agent: KMail/1.5.2
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
In-Reply-To: <20030604104215.GN4853@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306041246.21636.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 12:42, Jens Axboe wrote:

Hi Jens,

> > > the issue with batching in 2.4, is that it is blocking at 0 and waking
> > > at batch_requests. But it's not blocking new get_request to eat
> > > requests in the way back from 0 to batch_requests. I mean, there are
> > > two directions, when we move from batch_requests to 0 get_requests
> > > should return requests. in the way back from 0 to batch_requests the
> > > get_request should block (and it doesn't in 2.4, that is the problem)
> > do you see a chance to fix this up in 2.4?
> Nick posted a patch to do so the other day and asked people to test.
Silly mcp. His mail was CC'ed to me :( ... F*ck huge inbox.

ciao, Marc

