Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbVJLUJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbVJLUJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbVJLUJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:09:58 -0400
Received: from bno-84-242-95-19.nat.karneval.cz ([84.242.95.19]:41936 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751540AbVJLUJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:09:57 -0400
Message-ID: <434D6D83.1030308@gmail.com>
Date: Wed, 12 Oct 2005 22:09:39 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: mhw@wittsend.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <xslaby@fi.muni.cz>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       mhw@commandcorp.com, m.warfield@computer.org
Subject: Re: [PATCH 2.6.14-rc4] Maintainers one entry removed
References: <4af2d03a0510061516t32a62180t380dcb856d45a774@mail.gmail.com>	 <20051012170612.619C422AF21@anxur.fi.muni.cz>	 <1129143366.7966.19.camel@localhost.localdomain>	 <4af2d03a0510121137h2c89ee1fw35109a41351a8b2e@mail.gmail.com>	 <1129144483.20250.16.camel@canyon.wittsend.com>
In-Reply-To: <1129144483.20250.16.camel@canyon.wittsend.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damn, I can't post nor to LKML now?

On 10/12/05, Michael H. Warfield <mhw@wittsend.com> wrote:
> > Hello Michael, is the Computone intelliport multiport card still
> > maintained [and are you going to rewrite it to pci probing and the new
> > api?] and/or mhw@wittsend.com e-mail from MAINTAINERS still active (as
> > Alan wrote, I could be at on your black-list). So could you reply and
> > tell us?
>
>         You're not on a black list but CRM-114 may have caught you anyways.
Grr.
>
>         I thought the PCI stuff was there.  I'll look that over and see what
> needs to be done.  Got some pointers to docs on what I need to update
> for that? I was talking to Andrew about the spinlock problems but he
> didn't say anything about PCI probing.  What's missing?
I wrote it badly. The driver is written old-styled with
pci_find_device function, which Greg KH wants to eliminate from the
kernel. The way how to do it is to rewrite the driver to PCI hotplug
(not as much work). The code needs to be splitted, some for loops
would go away, you will get an event, when the device, you decribe in
pci_tbl, is in the system.

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
