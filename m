Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWHPUHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWHPUHo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWHPUHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:07:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:18104 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932203AbWHPUHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:07:43 -0400
Date: Thu, 17 Aug 2006 00:06:16 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: zach.brown@oracle.com, hch@infradead.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, akpm@osdl.org, netdev@vger.kernel.org
Subject: Re: [take9 1/2] kevent: Core files.
Message-ID: <20060816200616.GA8253@2ka.mipt.ru>
References: <20060816134550.GA12345@infradead.org> <20060816135642.GD4314@2ka.mipt.ru> <44E35F29.8010500@oracle.com> <20060816.124554.18301763.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060816.124554.18301763.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 17 Aug 2006 00:06:18 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 12:45:54PM -0700, David Miller (davem@davemloft.net) wrote:
> > >>> +	for (i=0; i<ARRAY_SIZE(u->kevent_list); ++i)
> > >> 	for (i = 0; i < ARRAY_SIZE(u->kevent_list); i++)
> > > 
> > > Ugh, no. It reduces readability due to exessive number of spaces.
> > 
> > Ihavetoverystronglydisagree.
> 
> Metoo. :-)
> 
> Spaces help humans parse out the syntactic structure of
> multi-token expressions.

There is an anecdote:
in a near future, when world crisis killed economy,
russain scientists found a way to make time machine, so they 
get some dictator from the past and ask him how to improve a situation.
He quickly answers that it is only needed to shoot all opposition, kill
the freedom and redraw Kremlin and Red Square into blue colour.
People wonder "such tragic steps, so much blood, but why Red Square?"
Dictator answers: well, if there are no objections about other issues,
we will not change Red Square.

I'm telling it just because I would like to know if there are any issues
which must be fixed in the tomorrow patchset except mentioned in
previous e-mails... :)

-- 
	Evgeniy Polyakov
