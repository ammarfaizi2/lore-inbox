Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTERJIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTERJIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:08:31 -0400
Received: from gw.enyo.de ([212.9.189.178]:48645 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261847AbTERJIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:08:30 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: sim@netnation.org, linux-kernel@vger.kernel.org
Subject: Re: Route cache performance under stress
References: <20030516222436.GA6620@netnation.com>
	<1053138910.7308.3.camel@rth.ninka.net> <87d6iit4g7.fsf@deneb.enyo.de>
	<20030517.150933.74723581.davem@redhat.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, sim@netnation.org, 
 linux-kernel@vger.kernel.org
Date: Sun, 18 May 2003 11:21:14 +0200
In-Reply-To: <20030517.150933.74723581.davem@redhat.com> (David S. Miller's
 message of "Sat, 17 May 2003 15:09:33 -0700 (PDT)")
Message-ID: <87iss87gqd.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: Florian Weimer <fw@deneb.enyo.de>
>    Date: Sat, 17 May 2003 09:31:04 +0200
>    
>    The hash collision problem appears to be resolved, but not the more
>    general performance issues.  Or are there any kernels without a
>    routing cache?
>
> I think your criticism of the routing cache is not well
> founded.

Well, what would change your mind?

I don't really care, as I maintain just one Linux router which routes
substantial bandwidth and which could easily be protected by upstream
ACLs in the case of an emergency.  Others rely on Linux routers for
their ISP business, and they see similar problems as well, and these
people *do* care about this problem.  Some of them contacted me and
told me that they were ignored when they described it.  They certainly
want this problem to be fixed, as using FreeBSD is not always an
option. 8-(
