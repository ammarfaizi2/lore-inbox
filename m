Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWHRXks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWHRXks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbWHRXkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:40:47 -0400
Received: from ns1.coraid.com ([65.14.39.133]:12908 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1751415AbWHRXkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:40:47 -0400
Date: Fri, 18 Aug 2006 19:10:38 -0400
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.18-rc4] aoe [10/13]: module parameter for device timeout
Message-ID: <20060818231037.GW29988@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com> <a47db3897e5de69fbe6bfaf1fea169a2@coraid.com> <1155942187.31543.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155942187.31543.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 12:03:07AM +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-18 am 13:39 -0400, ysgrifennodd Ed L. Cashin:
> > Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
> > 
> > The aoe_deadsecs module parameter sets the number of seconds that
> > elapse before a nonresponsive AoE device is marked as dead.
> > 
> 
> Isn't this a) per link dependant and b) needing to be runtime tuned
> (sysfs say ?)

No, this is just for users who need very fast failure.  The default
three minutes is good for things like short network interruptions and
even quick AoE device reboots, but users who aren't interested in that
kind of flexibility and want a fast failure generally want it always
and on every link.

-- 
  Ed L Cashin <ecashin@coraid.com>
