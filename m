Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUIUWDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUIUWDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUIUWDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 18:03:12 -0400
Received: from ozlabs.org ([203.10.76.45]:31929 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264530AbUIUWDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 18:03:09 -0400
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>, netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
References: <1095721742.5886.128.camel@bach>
	 <20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
Content-Type: text/plain
Message-Id: <1095803902.1942.211.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 07:58:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 22:36, Marc Ballarin wrote:
> On Tue, 21 Sep 2004 09:09:02 +1000
> "Rusty Russell (IBM)" <rusty@au1.ibm.com> wrote:
> 
> > Name: Warn that ipchains and ipfwadm are going away
> > Status: Trivial
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> Isn't a compile-time warning a bit "soft"? Especially when compilation of
> a kernel easily produces > 100 warnings, as it does right now.

Sure, but you have to start somewhere.  Next step will be #error.  Then
finally remove the whole thing (I don't want to remove the whole thing
to start with, since that would create a silent failure).

Cheers,
Rusty.
-- 
http://linux.conf.au - Call for papers.  Join us!

