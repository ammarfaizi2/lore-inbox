Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVDUUyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVDUUyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVDUUyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:54:47 -0400
Received: from coderock.org ([193.77.147.115]:29864 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261875AbVDUUyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:54:33 -0400
Date: Thu, 21 Apr 2005 22:54:25 +0200
From: Domen Puncer <domen@coderock.org>
To: Ed L Cashin <ecashin@coraid.com>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces configuration
Message-ID: <20050421205425.GA14686@nd47.coderock.org>
References: <3VqSf-2z7-15@gated-at.bofh.it> <E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org> <87y8bcjlpq.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y8bcjlpq.fsf@coraid.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/05 09:36 -0400, Ed L Cashin wrote:
> "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de> writes:
> 
> > Ed L Cashin <ecashin@coraid.com> wrote:
> >
...
> >> +  /sys/module/aoe/parameters/aoe_iflist instead of
> >                                 ^^^
> >
> > Why does the module name need to be part of the attribute?
> > That's redundant. That's redundant.
> 
> Yes.  That's true.  Redundancy isn't always bad, though, and using the
> "aoe_" prefix lets the kernel parameter for the built-in aoe driver be
> the same as the parameter for the modular driver.

The __setup() stuff is redundancy too, as module parameters already
work as boot parameters (ie. aoe.iflist).


	Domen
