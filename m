Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVHVWU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVHVWU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVHVWUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:20:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:8328 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751362AbVHVWT0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:19:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hOzhgTDhuT9euzGF0Qr+X+kwnpUhIlEFBM5eJ7k1dJ205j0+peOO0k75IN/JntlLvcwvwEjvtYhFl0tU7qoNm8B9cDbXGczB26wpARorf0uGlKAahGIPvLAT137lKMkGdbFotmNOwrsBHvUXmc5wcADZMbVUd7vS/ZQTFDC9oWo=
Message-ID: <58cb370e05082203325eb55c03@mail.gmail.com>
Date: Mon, 22 Aug 2005 12:32:55 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IRQ problem with PCMCIA
Cc: David Hinds <dhinds@sonic.net>, "Hesse, Christian" <mail@earthworm.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
In-Reply-To: <1124706770.7281.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508212043.58331.mail@earthworm.de>
	 <20050821221739.GA18925@sonic.net> <20050821221935.GB18925@sonic.net>
	 <1124671082.1101.0.camel@localhost.localdomain>
	 <58cb370e050822022556595fa1@mail.gmail.com>
	 <1124706770.7281.13.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2005-08-22 at 11:25 +0200, Bartlomiej Zolnierkiewicz wrote:
> > CardBus IDE devices work just fine but there are still issues with
> > hotplug support (work in progress).
> 
> "work in progress". Yes because I submitted working IDE cardbus hotplug
> support, and Mark Lord submitted a Delkin driver both of which worked
> months ago rather nicely and neither of which hit the Bartlomiej stone
> wall and never got in and are now stale patches.

Your hotplug support was bad from design/maintainability/workability
POVs so got NAK-ed for a good reasons.  Delkin driver can be integrated
soon.

"working nice" != "acceptable for kernel.org"

Because of "working nice" attitude IDE driver became such a mess.

> > > up ever getting those into the kernel. Please wait instead for the new
> > > SATA/ATA layer to develop hotplug support.
> >
> > This is just a FUD to discourage people from working on IDE drivers.
> > Alan is doing this on purpose and doesn't really want to improve things.
> 
> Its a realistic assessment based upon over ten years working on the
> Linux kernel. I do not believe you are capable of fixing the old IDE
> code. But don't take that personally I am sceptical than anyone can fix
> the old IDE code.

I'll keep trying you can keep whining.

Bartlomiej
