Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269900AbTHBRcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269950AbTHBRcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 13:32:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26878 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269900AbTHBRcx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 13:32:53 -0400
Message-ID: <3F2BF5C7.90400@us.ibm.com>
Date: Sat, 02 Aug 2003 10:32:55 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
References: <20030802140444.E5798@almesberger.net>
In-Reply-To: <20030802140444.E5798@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

> (*) The InfiniBand people unfortunately call also their TCP/IP
>     bypass "TOE" (for which they promptly get shouted down,
>     every time they use that word). This is misleading, because

Thank you! Yes! All in favor say Aye..AYE!!! Motion passes,
the infiniband people don't get to call it TOE anymore..

> While I'm not entirely convinced about the usefulness of TOE in
> all the cases it's been suggested for, I can see value in certain
> areas, e.g. when TCP per-packet overhead becomes an issue.

Ditto, but I see it being used to rollout the idea and process,
rather than anything of value now, and the lessons are being
learned for the future, when we reach 20Gb, 40Gb, even faster
networks of tommorow. The processors might keep up, but nothing
else will, for sure.

> However, I consider the approach of putting a new or heavily
> modified stack, which duplicates a considerable amount of the
> functionality in the main kernel, on a separate piece of hardware
> questionable at best. Some of the issues:
> 
>  - if this stack is closed source or generally hard to modify,
>    security fixes will be slowed down

as will bug fixes, and debugging becomes a right royal pain.

Also, most profiles of networking applications show the
largest blip is essentially the user<->kernel transfer, and
that would still remain the unaddressed bottleneck.

> So, how to do better ? Easy: use the Source, Luke. Here's my
> idea:
> 
>  - instead of putting a different stack on the TOE, a
>    general-purpose processor (probably with some enhancements,
>    and certainly with optimized data paths) is added to the NIC

The thing is, all the TOE efforts are propietary ones, to
my limited knowledge. Thus all the design is occurring in
confidential, vendor internal forums. How will they/we
come up with really the needed, _common_ design approach?

Or is this not so needed?

thanks,
Nivedita

