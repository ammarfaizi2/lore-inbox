Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVKIMao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVKIMao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKIMao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:30:44 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:24115 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750706AbVKIMao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:30:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tWXV5nBDzsognoGCUuom2j6ajqbQFbp5Fw7XOa4DeezBkGBNHzIOj1d7dBoTBqP3lBzwAx8e7fZAQCo5Xay64pBom9BHPk5x0RkR6JJKfy6td98B1lyM8C52Z6EeD8ewEQf44qeIDZim/N3t5he5XZok5pZtWTvcgwzcNAcs8hg=
Message-ID: <5a2cf1f60511090430y63db5473we40f077070ecb43a@mail.gmail.com>
Date: Wed, 9 Nov 2005 13:30:43 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Calin Szonyi <caszonyi@rdslink.ro>
Subject: Re: New Linux Development Model
Cc: Edgar Hucek <hostmaster@ed-soft.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0511090202030.2383@grinch.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436C7E77.3080601@ed-soft.at>
	 <20051105122958.7a2cd8c6.khali@linux-fr.org>
	 <436CB162.5070100@ed-soft.at>
	 <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
	 <436DEEFC.4020301@ed-soft.at>
	 <5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com>
	 <Pine.LNX.4.62.0511090202030.2383@grinch.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/05, caszonyi@rdslink.ro <caszonyi@rdslink.ro> wrote:
[...]
> >> reasons why a user wanna upgrade to new kernel. Maybe new supported
> >> hardware and so on. It's frustrating for the user, have on the one side the
> >> new hardware supported but on the other side, mybe broken support for
> >> the existing hardware.
> >
> > New kernel feature and new supported hardware would be the only reason
> > for me to upgrade. Personally that doesn't come that often. My
> > hardware configurations don't change that much. I make sure it's well
> > supported, not just recently. When one buys a non supported hardware,
> > one should know the path chosen won't be the easiest.
> >
>
> There are other reasons for using a new kernel. One of them is
> interactivity. In the days of 2.4 one could achieve decent interactivity
> for the desktop using preempt and low latency patches. For 2.6
> interactivity was a real issue (possibly because of the new development
> model).

I don't get it. You say that with 2.4 + patches you had good
interactivity and with 2.6 you don't? Why did you switch then?

> >> And why should dirstribution makers always backport new security fixes ?
> >
> > Because they want to ensure maximum stability. That's what users are
> > (sometimes) paying for.
> >
>
> Maximum stability of what ? If the distribution kernels are based on
> vanila kernel (i.e. are based on unstable kernel) how stable will they be
> ?

Maximum stability of the kernel they deliver. When you fix a
vulnerability, you fix a vulnerability. You don't just happen to add a
new bunch of features, and a new bunch of bugs. Otherwise you are
going to piss off your users a lot.

Everybody does that, including Microsoft (most of the time).

>   On lkml someone said that "stable means it won't crash very often".
> This sounds like Windows(TM)

I've had Linux running on various hardware, from Pentium I machines to
AMD 64bits machines and various laptops. The most problematic hardware
I've had to deal was a MythTV box running on a Via EPIA M motherboard
(due to what seems to be DMA issues on the board), and PCMCIA hang a
on a Dell laptop. Some installation issues on new hardware and a
wireless pcmcia card whose drivers are not stable. Apart from that,
Linux has always been running very well. I had less than 10 hangs and
hard reboots in 8 year with 20 machines. I had more oopses but 95% of
the time confined to a module and not critical. And I've had more
hardware failures, drives, disks, keyboards, pcmcia&usb ports, mice,
motherboard than kernel issues.

On the security side, I've been broken into twice, one because of a
very dumb misconfiguration on my part on a desktop (guest/guest
account, no firewall, ssh server enabled and not restricted....), one
on a server, probably because of an external php program whose
security was not handled by the distribution (haven't investigated the
issue yet, server is down).

To me, the most problematic crashes on desktops are X failures,
because I lose several minutes to set up my desktop again.

And firefox crashes (or becomes unusable) way too often (around twice a week).

> > And second 90% of the security issues will not affect the majority of
> > the home users (because they are restricted to a particular area of
> > the kernel not affecting the user, or because they already require
> > access on the machine to be exploitable). You will have much more
> > risks using a box with an unpatched php or apache than with an
> > unpached kernel, or without a proper firewall configuration.
> >
>
> Some holes are remote ;-)

That's your 10% (probably even much lower than that). And if you have
a firewall on your desktop, most services turned down, and are behind
a private network with a router with its own firewall, the probability
that you get a remote attack on your particular version of the kernel,
for which they are very few exploits in the wild anyway, is much lower
than having a hard drive failure or a X server crash because of a
driver issue.

If you care about stability, don't touch what works.

J
