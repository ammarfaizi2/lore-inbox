Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUF0DAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUF0DAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 23:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUF0DAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 23:00:09 -0400
Received: from [12.177.129.25] ([12.177.129.25]:21443 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S266531AbUF0DAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 23:00:06 -0400
Date: Sat, 26 Jun 2004 23:53:11 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Christoph Hellwig <hch@infradead.org>,
       BlaisorBlade <blaisorblade_spam@yahoo.it>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of UML in 2.6.8
Message-ID: <20040627035311.GA8842@ccure.user-mode-linux.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it> <20040626181048.GA16323@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626181048.GA16323@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 07:10:48PM +0100, Christoph Hellwig wrote:
> Please send split patches.  E.g. linux/ghash.h should not ne reintroduced,
> it's completely fuly.  

That requires a little interface work inside UML, and that was the main reason
Andrew hasn't seen UML recently.

> Also your above arch_free_page needs some more
> discussion.

I think that can disappear.  In some cases, it might be handy for the arch
to see pages being freed, but right now, I believe that UML has no need for
it.

				Jeff
