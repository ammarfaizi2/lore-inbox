Return-Path: <linux-kernel-owner+w=401wt.eu-S965054AbWL2Jfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWL2Jfz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 04:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWL2Jfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 04:35:55 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:40900 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965051AbWL2Jfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 04:35:54 -0500
Date: Fri, 29 Dec 2006 11:55:04 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: Re: [take29 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061229085503.GB13816@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11668927001365@2ka.mipt.ru> <20061228160137.GA19301@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061228160137.GA19301@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 05:01:37PM +0100, Ingo Molnar (mingo@elte.hu) wrote:
> 
> * Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > Generic event handling mechanism.
> 
> i see it covers alot of event sources, but i cannot see block IO 
> notifications. Am i missing something?

Depending on what it is :)
If you mean kevent based AIO, then it was dropped to reduce size of the
patchset, and in favour of new AIO design.
Other kinds of read/write notifications can be handled by poll/select
notifications.

> 	Ingo

-- 
	Evgeniy Polyakov
