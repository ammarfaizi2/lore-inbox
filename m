Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263390AbTCNRBb>; Fri, 14 Mar 2003 12:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263394AbTCNRBb>; Fri, 14 Mar 2003 12:01:31 -0500
Received: from [80.190.48.67] ([80.190.48.67]:65030 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S263390AbTCNRB1> convert rfc822-to-8bit; Fri, 14 Mar 2003 12:01:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre5aa1
Date: Fri, 14 Mar 2003 18:05:48 +0100
User-Agent: KMail/1.4.3
References: <20030314090825.GB1375@dualathlon.random> <200303141437.11589.m.c.p@wolk-project.de>
In-Reply-To: <200303141437.11589.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303141805.48834.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 March 2003 14:39, Marc-Christian Petersen wrote:

Hi Andrea,

> I get _tons_ of these messages:

> rq->prev_mm was c40dddc0 set to c40ddf00 - grep
> cb795f64 c0115786 c023b1a0 c40dddc0 c40ddf00 cb79424e c011bd9d cb7fc02c
>        cb794000 00000000 c16fa7a0 c158d200 cb794000 00000000 c011c1da
> cb794000 c16fa7a0 cb794000 4012e8c4 00000000 bffff838 c011c233 00000000
> c010720f Call Trace: [<c0115786>]  [<c011bd9d>]  [<c011c1da>]  [<c011c233>]
> [<c010720f>]
> rq->prev_mm was c40ddf00 set to cb78a0c0 - grep
> cb789f64 c0115786 c023b1a0 c40ddf00 cb78a0c0 cb78824e c011bd9d cb7fc02c
>        cb788000 00000000 c16fa760 c158d200 cb788000 00000000 c011c1da
> cb788000 c16fa760 cb788000 4012e8c4 00000000 bffff838 c011c233 00000000
> c010720f Call Trace: [<c0115786>]  [<c011bd9d>]  [<c011c1da>]  [<c011c233>]
> [<c010720f>]
> Machine:
> Celeron 1,3GHz, UP, 512MB RAM, IDE.

hmm dunno why the following line were not in the pastings above.

Call Trace: [do_schedule+471/656] [do_exit+522/560] [sys_exit+19/32] 
[system_call+51/56]

ciao, Marc


