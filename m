Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVKFNnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVKFNnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 08:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVKFNnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 08:43:31 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:4272 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750835AbVKFNnb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 08:43:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iiS+bhtIjYtI1PiVZ/ceKcq4sFQ8Bcb/hobymEMsxCXqYe+TEaah8MKuc5duKY0Vn71AiQjzlxq37KAKrDQWOQ0GTz4j/ap8BEa1NQZMRX50iocEMITLVnGURT7EfCz5BwfEVsZwZCEAXYzeV09owHQTjN0iFkYE4vk5S/2AHlk=
Message-ID: <5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com>
Date: Sun, 6 Nov 2005 14:43:30 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Edgar Hucek <hostmaster@ed-soft.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
In-Reply-To: <436DEEFC.4020301@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436C7E77.3080601@ed-soft.at>
	 <20051105122958.7a2cd8c6.khali@linux-fr.org>
	 <436CB162.5070100@ed-soft.at>
	 <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
	 <436DEEFC.4020301@ed-soft.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/05, Edgar Hucek <hostmaster@ed-soft.at> wrote:
> jerome lacoste wrote:
[...]
> >I will ask you just one question: as a user, why did you want to
> >upgrade your kernel?
> >
> >
> Depends on the user and what he wants to do. There are several
> reasons why a user wanna upgrade to new kernel. Maybe new supported
> hardware and so on. It's frustrating for the user, have on the one side the
> new hardware supported but on the other side, mybe broken support for
> the existing hardware.

New kernel feature and new supported hardware would be the only reason
for me to upgrade. Personally that doesn't come that often. My
hardware configurations don't change that much. I make sure it's well
supported, not just recently. When one buys a non supported hardware,
one should know the path chosen won't be the easiest.

> >On a server you want stability. So you don't upgrade.
> >
> Sure, but what about securrity updates. When a new kernel release
> comes out the updates are stopped for older releases.

For vanilla kernels, yes.

> And why should dirstribution makers always backport new security fixes ?

Because they want to ensure maximum stability. That's what users are
(sometimes) paying for.

And second 90% of the security issues will not affect the majority of
the home users (because they are restricted to a particular area of
the kernel not affecting the user, or because they already require
access on the machine to be exploitable). You will have much more
risks using a box with an unpatched php or apache than with an
unpached kernel, or without a proper firewall configuration.

> >On a desktop, there are probably a bunch of out of kernel modules that will need
> >upgrading with each new kernel modules. Just on the laptop I am using
> >right now, I will have to upgrade the vmware bridge, nvidia driver,
> >madwifi wireless driver, etc. And that's normal. The new development
> >model didn't change that.
> >
> >
>  From my point of view, it makes a difference if i have to recompile
> a module or realy upgrade it.

That only happens for out ot tree modules, which shouldn't be really
out of tree in the first place. That's the issue. If they are out of
tree, it's for a reason. Either they cannot be in tree, or they are
not stable enough.

There you see the issue.

> [...]
> cu
>
> ED.

Jerome
