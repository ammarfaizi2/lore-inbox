Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRAZFSi>; Fri, 26 Jan 2001 00:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131274AbRAZFS2>; Fri, 26 Jan 2001 00:18:28 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:44302 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129367AbRAZFSQ>;
	Fri, 26 Jan 2001 00:18:16 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101260517.f0Q5Hna262139@saturn.cs.uml.edu>
Subject: Re: Bug in ppp_async.c
To: paulus@linuxcare.com.au
Date: Fri, 26 Jan 2001 00:17:49 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), l_indien@magic.fr, jma@netgem.com,
        jfree@sovereign.org, linux-kernel@vger.kernel.org
In-Reply-To: <14958.42045.576523.62083@argo.linuxcare.com.au> from "Paul Mackerras" at Jan 24, 2001 08:45:33 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras writes:
> Albert D. Cahalan writes:

>> Even Red Hat 7 only has the 2.3.11 version.
>>
>> The 2.4.xx series is supposed to be stable. If there is
>> any way you could add a compatibility hack, please do so.
>
> Stable != backwards compatible to the year dot.

I know. It means that you don't break the API between 2.4.0
and 2.4.1 though. It means you don't break distributions that
were supposed to be ready for the 2.4.xx kernels.

> ppp-2.4.0 has been
> out for over 5 months now.

That is less than the typical time between releases of
a normal Linux distribution.

> Adding the compatibility stuff back in
> would make the PPP subsystem much more complicated and less robust.

I wouldn't be asking you to add it back if you hadn't
removed it. It was already there.

I don't trust that the new version will be a drop-in replacement
due to past experiences, and I wonder if my 2.0.xx kernel will
still be supported by the new user-space code. So this sucks.

> And pppd is not the only thing you would have to upgrade if you are
> using a 2.4.0 with Red Hat 7.0 - I would expect that you would also at
> least have to upgrade modutils, and switch over from ipchains to
> iptables if you use the netfilter stuff.

Nope, the network people even offer some Linux 2.0 compatibility.
That dates back many years! Hey, I like your example.

For modutils, there was a security problem anyway.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
