Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTHaKlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 06:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTHaKlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 06:41:14 -0400
Received: from dyn-ctb-210-9-245-93.webone.com.au ([210.9.245.93]:14599 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262600AbTHaKlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 06:41:09 -0400
Message-ID: <3F51D0BD.8030307@cyberone.com.au>
Date: Sun, 31 Aug 2003 20:41:01 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SHED] Questions.
References: <1062324435.9959.56.camel@big.pomac.com>	 <3F51CB44.3080805@cyberone.com.au> <1062325465.5171.60.camel@big.pomac.com>
In-Reply-To: <1062325465.5171.60.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kumlien wrote:

>On Sun, 2003-08-31 at 12:17, Nick Piggin wrote:
>
>>Search for "Nick's scheduler policy" ;)
>>
>
>Heh, yeah, i have been following your and con's work via
>marc.theaimsgroup.com. =)
>

Well, my patch does almost exactly what you describe.

>
>But wouldn't ingos off the shelf stuff work better with the quantum
>values like that?
>

That means more complexity and behaviour that is more difficult
to trace. The interactivity stuff is already a monster to tune.

>
>And is the preempt min quantum in there?
>

No. If you do that, you'll either break the priority concept very
badly, or you'll break it a little bit and turn the scheduler into
an O(n) one.


