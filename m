Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275126AbTHAG1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275127AbTHAG1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:27:54 -0400
Received: from dyn-ctb-210-9-244-141.webone.com.au ([210.9.244.141]:32774 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S275126AbTHAG1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:27:49 -0400
Message-ID: <3F2A0863.5070806@cyberone.com.au>
Date: Fri, 01 Aug 2003 16:27:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
References: <1059697921.30747.54.camel@big.pomac.com>
In-Reply-To: <1059697921.30747.54.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kumlien wrote:

>Hi all,
>
>I have been following the sheduler and interactivity discussions closely
>but via the marc.theaimsgroup.com archive, So i might be behind etc...
>=P
>
>[Note: sorry if i sound like mr.know-it-all etc, just trying to get a
>point across]
>
>Anyways, i think that the AS discussions that i have seen has missed
>some points. Getting the processes priority in AS is one thing, but fist
>of all i think there should be a stand off layer. Let me explain:
>
>I liked Jens Axobe's 'CBQ' alike implementation (based on the idea of
>Andrea A. (afair i have the names right) since it does the most
>important thing... which is *nothing* when there is no load (ie, pass
>trough).
>
>AS might be/is the best damn io sheduler for loaded machines but when
>there is no load, it's overhead. So in my opinion there should be
>something that first warrants the usage of AS before it's actually
>engaged.
>
>And, if it's only engaged during high load, additions like basing the
>requests priority on the process/tasks priority would make total sense,
>adding the 'wakeup on wait' or what it was would also make total
>sense... But how many of your machines uses the disk 100% of the time?
>(in the real world... )
>
>I don't know how 'CBQ' was implemented but any 'we are under load now'
>trigger would do it for me.
>
>Please see to it that my CC is included in any discussions =)
>
>PS. Or was it a version of SFQ? in that case s/CBQ/SFQ/g
>

To start with its CFQ. Also could you clarify what you mean by
load and what you mean by CFQ doing nothing, and why AS is overhead
in the no load case. I can't really follow what you are saying.


