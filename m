Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTETAl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTETAlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:41:24 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:39327 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263381AbTETAj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:39:57 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 19 May 2003 17:52:03 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Dan Kegel <dank@kegel.com>, John Myers <jgmyers@netscape.com>,
       linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Comparing the aio and epoll event frameworks.
In-Reply-To: <20030520004636.GP2444@holomorphy.com>
Message-ID: <Pine.LNX.4.55.0305191749130.6565@bigblue.dev.mcafeelabs.com>
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net>
 <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com>
 <3EC9807D.3080804@kegel.com> <20030520004636.GP2444@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, William Lee Irwin III wrote:

> Davide Libenzi wrote:
> >> Adding a single shot feature to epoll takes about 5 lines of code,
> >> comments included :) You know how many reuqests I had ? Zero, nada.
>
> On Mon, May 19, 2003 at 06:10:21PM -0700, Dan Kegel wrote:
> > I thought edge triggered epoll *was* single-shot.
> > - Dan
>
> fs/eventpoll.c suggests "epoll" stands for "eventpoll" as opposed to
> "edge-triggered". Davide, did the LT additions prompt the renaming or
> was this always the case?

It was both actually :) It meant event-poll and also was edge-triggered.
Now you can have it level-triggered on a per-fd basis. The epoll named was
not a good one from the beginning though :)


- Davide

