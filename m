Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318165AbSIBKZl>; Mon, 2 Sep 2002 06:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318265AbSIBKZl>; Mon, 2 Sep 2002 06:25:41 -0400
Received: from holomorphy.com ([66.224.33.161]:32409 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318165AbSIBKZk>;
	Mon, 2 Sep 2002 06:25:40 -0400
Date: Mon, 2 Sep 2002 03:24:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: phillips@arcor.de, rml@tech9.net, rusty@rustcorp.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Message-ID: <20020902102432.GQ888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, phillips@arcor.de,
	rml@tech9.net, rusty@rustcorp.com.au, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20020902060257.GO888@holomorphy.com> <20020901.232021.00308364.davem@redhat.com> <E17loBW-0004gM-00@starship> <20020902.030553.14354294.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020902.030553.14354294.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 03:05:53AM -0700, David S. Miller wrote:
> A list node is markably different from "the list" itself.
> A "list" is the whole of all the nodes on the list, not just one
> of them.

Linus will be the final arbiter of taste here. I've largely said my
peace, but will step forth from the shadows long enough to say the
decision here (and dear gawd, this is a trivial issue) hinges on this:
(1) one may describe the data structure as accurately as possible, so
	struct list_marker, struct list_node, or (gawd forbid)
	struct list_head is the proper name in this context.
(2) brevity is the soul of wit, and the rest may be assumed to be the
	burden of knowing how to program, so struct list must be
	twisted a very small bit so it's understood this is a list node
	and/or head when the abbreviated name is used.
At this point, I beg of you all, defer to Linus and produce useful
things instead of debating this kind of issue endlessly. It's basic.
It's fundamental. It's trivial. And it's his kernel. Yes, I'm
authoritarian, and no, I'm not in charge. These simple things are too
easy to debate. The real coding lies elsewhere. Now let's move on please.

Thanks,
Bill
