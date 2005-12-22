Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVLVRJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVLVRJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbVLVRJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:09:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:1414 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030205AbVLVRJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:09:26 -0500
Message-ID: <43AAEF6E.47CCEFE0@tv-sign.ru>
Date: Thu, 22 Dec 2005 21:24:46 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, inaky.perez-gonzalez@intel.com,
       tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH 02/02] RT: plist namespace cleanup
References: <1135202230.22970.15.camel@localhost.localdomain>
		 <43AAB3C8.DB304856@tv-sign.ru> <1135270381.3696.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
> On Thu, 2005-12-22 at 17:10 +0300, Oleg Nesterov wrote:
> > Daniel Walker wrote:
> > >
> > >         Make the plist namespace consistent.
> >
> > I think plist_head is much better than pl_head.
> >
> > However I think plist_empty/plist_unhashed is more accurate
> > than plist_head_empty/plist_node_empty, but I am rather
> > agnostic to naming.
> 
> unhashed seems very meaningless . We're not hashing anything.

Still we already have hlist_empty/hlist_unhashed

> > Daniel, it would be great if you can check that kernel/rt.o
> > was not changed after rename (as it should be).
> 
> I didn't check, but I made no code changes so it should be any
> different.

That is why I asked. It is very easy to make a mistake by accident
while doing trivial changes, but it is not easy to notice.

Oleg.
