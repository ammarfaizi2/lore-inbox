Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131109AbQLNPcn>; Thu, 14 Dec 2000 10:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130525AbQLNPcV>; Thu, 14 Dec 2000 10:32:21 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53776 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S130570AbQLNPcM>; Thu, 14 Dec 2000 10:32:12 -0500
Message-ID: <3A38ED15.6EE42F31@evision-ventures.com>
Date: Thu, 14 Dec 2000 16:53:57 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        shirsch@adelphia.net, linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
In-Reply-To: <200012141403.eBEE3Ts46579@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >> BSD has curproc, but that is considerably less likely to be
> >> used in "inoccent code" than "current".  I mean, "current what?".
> >> It could be anything, current privledges, current process, current
> >> thread, the current time...
> >
> >I see and I assume calling a random collection of data
> >
> >       u.something
> >
> >in BSD was even more logical  8)
> 
> The only place I've seen this in BSD is for defining a "union" of
> data within a structure.  I don't think its ever been #defined into
> a namespace.
> 
> >current is a completely rational name. The problem with current on some of
> >our ports right now is that its a #define. That is a trap for the unwary and
> >one day wants fixing.
> 
> Exactly.
> 
> >curproc would be incorrect for linux since its the current task,
> >and a task and unix process are not the same thing
> 
> I'm aware of the difference.  I only mentioned "curproc" as an example of
> similar brokeness that has less of a chance of catching the uninitiated.
> What about "curtask" or "curthread"?

What's wrong with current? It's perfectly fine, since it's the main data
context entity you are working with during it's usage... Just remember
it as
CURRENT MAIN PROBLEM the kernel is struggling with at time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
