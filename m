Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLXJaK>; Sun, 24 Dec 2000 04:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQLXJaB>; Sun, 24 Dec 2000 04:30:01 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:7693 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129431AbQLXJ3x>;
	Sun, 24 Dec 2000 04:29:53 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012240859.eBO8xNU506215@saturn.cs.uml.edu>
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 24 Dec 2000 03:59:23 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1g0jfr0ms.fsf@frodo.biederman.org> from "Eric W. Biederman" at Dec 23, 2000 01:40:43 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:

> If you are doing a real time task you don't want to very close
> to your performance envelope.  If you are hitting the performance
> envelope any small hiccup will cause you to miss your deadline,
> and close to your performance envelope hiccups are virtually certain.
>
> Pushing the machine just 5% slower should get everything going
> with multiple pages, and you wouldn't be pushing the performance
> envelope so your machine can compensate for the occasional hiccup.
>
>> The data stream is fat and relentless.
>
> So you add another node if your current nodes can't handle the load
> without using giant physical areas of memory.  Attempt to redesign
> the operating system.  Much more cost effective.

Nodes can be wicked expensive. :-)

Pushing the performance envelope is important when you want to
sell lots of systems. Radar is a similar computational task,
with the added need to reduce space and weight requirements.
It's not OK to be 5% more expensive, bulky, and heavy.

Also the Airplane Principal: more nodes means more big failures.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
