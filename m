Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLNOfI>; Thu, 14 Dec 2000 09:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130198AbQLNOe5>; Thu, 14 Dec 2000 09:34:57 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:30227 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129431AbQLNOew>; Thu, 14 Dec 2000 09:34:52 -0500
Message-Id: <200012141403.eBEE3Ts46579@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: davem@redhat.com (David S. Miller), shirsch@adelphia.net,
        linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Thu, 14 Dec 2000 10:18:49 GMT."
             <E146VTQ-00045T-00@the-village.bc.nu> 
Date: Thu, 14 Dec 2000 07:03:29 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> BSD has curproc, but that is considerably less likely to be
>> used in "inoccent code" than "current".  I mean, "current what?".
>> It could be anything, current privledges, current process, current
>> thread, the current time...
>
>I see and I assume calling a random collection of data
>
>	u.something
>
>in BSD was even more logical  8)

The only place I've seen this in BSD is for defining a "union" of
data within a structure.  I don't think its ever been #defined into
a namespace.

>current is a completely rational name. The problem with current on some of
>our ports right now is that its a #define. That is a trap for the unwary and
>one day wants fixing.

Exactly.

>curproc would be incorrect for linux since its the current task,
>and a task and unix process are not the same thing

I'm aware of the difference.  I only mentioned "curproc" as an example of
similar brokeness that has less of a chance of catching the uninitiated.
What about "curtask" or "curthread"?

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
