Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272405AbTHEDYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272413AbTHEDYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:24:14 -0400
Received: from dyn-ctb-210-9-244-254.webone.com.au ([210.9.244.254]:12300 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272405AbTHEDYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:24:11 -0400
Message-ID: <3F2F231C.3030901@cyberone.com.au>
Date: Tue, 05 Aug 2003 13:23:08 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O11int for interactivity
References: <200307301038.49869.kernel@kolivas.org> <20030802225513.GE32488@holomorphy.com> <200308030119.47474.m.c.p@wolk-project.de> <200308042106.51676.m.c.p@wolk-project.de> <20030804195335.GK32488@holomorphy.com> <3F2F00B0.9050804@cyberone.com.au> <20030805024103.GM32488@holomorphy.com> <3F2F1F80.7060207@cyberone.com.au> <20030805031341.GN32488@holomorphy.com>
In-Reply-To: <20030805031341.GN32488@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Tue, Aug 05, 2003 at 01:07:44PM +1000, Nick Piggin wrote:
>
>>Let me know if you come up with anything significant ;)
>>
>
>Well, I was vaguely hoping a useful way to instrument the io stuff
>would already be out there.
>
>

Not really.
For a process doing blocking reads you could measure the time
from when a process submits a read to when it gets the result.
I suppose you also need some minimum rate too but I really can't
see that being the problem here.


