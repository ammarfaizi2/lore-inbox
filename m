Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUHLBCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUHLBCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUHLBCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 21:02:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8164 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268365AbUHLA7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:59:37 -0400
Date: Wed, 11 Aug 2004 20:59:33 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Zenaan Harkness <zen@freedbms.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: vservers on OpenMosix ??
In-Reply-To: <1092268911.4477.90.camel@whiskas>
Message-ID: <Pine.LNX.4.44.0408112057400.23161-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Zenaan Harkness wrote:

> Is anyone doing this? Is it possible?

It might be possible, but is probably quite a lot of work.

> Wouldn't it be the ultimate clustering solution?

Not if MOSIX still has the problem that when one machine
crashes, you lose all the processes that started on that
system or have any services running on that system.

Also, IPC across the network isn't very fast, so it may
be better for performance if all the processes from a
single virtual system run on one physical system...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

