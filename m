Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTIDDzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbTIDDzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:55:05 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:37544 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264629AbTIDDzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:55:00 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 3 Sep 2003 20:47:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
In-Reply-To: <20030904023446.GG5227@work.bitmover.com>
Message-ID: <Pine.LNX.4.56.0309032015100.2146@bigblue.dev.mdolabs.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
 <20030903173213.GC5769@work.bitmover.com> <89360000.1062613076@flay>
 <20030904003633.GA5227@work.bitmover.com> <6130000.1062642088@[10.10.2.4]>
 <20030904023446.GG5227@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Larry McVoy wrote:

> Maybe because history has shown over and over again that your pet theory
> doesn't work.  Mine might be wrong but it hasn't been proven wrong.  Yours
> has.  Multiple times.

Ok, who will be using this Larry ? Seriously. You tought us to be market
and business driven, so please tell us why this should be done. Will business
that are already using Beowulf style clusters migrate to SSI ? Why should
they ? They already scale well because they're running apps that scale
well on that type of cluster, and Beowulf style clusters are cheap and
faster for apps that do not share. Will business that are using application
servers like Java, .NET or whatever migrate to the super SSI ? Nahh, why
should they. Their apps server will be probably running thousands of
cluster-unaware threads (and sharing a shit-load of memory) that will make
SSI to look pretty ugly compared to a standard SMP/NUMA. Ok, they will be
cheaper if implemented with cheaper 1..4 way SMPs. But at the very end, to
get maximum performance from SSI you must have apps with a little of
awareness of the system they're running on. So you must force businesses
to either migrate their apps (cost of HW wayyy cheaper than cost of
developers) or to suffer from major performance problems. So my question
to you splits in two parts. Why companies selling HW should go with this
solution (cheaper for the customer) ? And more, why should business buy
into it, with the plan of having to rewrite their server infrastructure
to take full advantage of the new architecture ? Maybe, at the very end,
their is a reason why nobody is doing it.



- Davide

