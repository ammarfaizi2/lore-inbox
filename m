Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWHVWRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWHVWRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 18:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWHVWRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 18:17:36 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43697
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751279AbWHVWRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 18:17:35 -0400
Date: Tue, 22 Aug 2006 15:17:47 -0700 (PDT)
Message-Id: <20060822.151747.56047759.davem@davemloft.net>
To: akpm@osdl.org
Cc: rdunlap@xenotime.net, nmiell@comcast.net, johnpol@2ka.mipt.ru,
       linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060822150144.058d9052.akpm@osdl.org>
References: <1156281182.2476.63.camel@entropy>
	<20060822143747.68acaf99.rdunlap@xenotime.net>
	<20060822150144.058d9052.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, 22 Aug 2006 15:01:44 -0700

> If there _is_ something wrong with kqueue then let us identify those
> weaknesses and then diverge.

Evgeniy already enumerated this, both on his web site and in the
current thread.

Unlike some people seem to imply, Evgeniy did research all the other
implementations of event queueing out there, including kqueue.
He took the best of that survey, adding some of his own ideas,
and that's what kevent is.  It's not like he's some kind of
charlatan and made arbitrary decisions in his design without any
regard for what's out there already.

Again, the proof is in the pudding, he wrote applications against his
interfaces and tested them.  That's what people need to really do if
they want to judge his interface, try to write programs against it and
report back any problems they run into.
