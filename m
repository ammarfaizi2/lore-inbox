Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSFQEaV>; Mon, 17 Jun 2002 00:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316709AbSFQEaT>; Mon, 17 Jun 2002 00:30:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43723 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316705AbSFQEaS>;
	Mon, 17 Jun 2002 00:30:18 -0400
Date: Mon, 17 Jun 2002 06:28:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Robert Love <rml@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <20020617001353.GA8450@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0206170627210.4177-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jun 2002, J.A. Magallon wrote:

> - the irqbalance patch for p4 needs idle_cpu (and not sure about idle_task).
>   BTW, they were macros before...
> - the bproc patch needs task_nice (you can be less interested in this, but
>   it does not hurt...)
> 
> So could I ask you, please
> - to make public idle_[cpu,task], as macros or exported functions, here it
>   does not matter, irqbalance is not a module. Perhaps some other piece of code
>   could need them.
> - to export all the set/get prio/nice interfaces
> 
> ???

sure.

	Ingo

