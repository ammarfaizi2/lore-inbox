Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUGWVMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUGWVMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268066AbUGWVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 17:12:46 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:11682 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268065AbUGWVMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 17:12:44 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [RFC]: CONFIG_UNSUPPORTED (was: Re: [PATCH] delete devfs)
Date: Fri, 23 Jul 2004 23:22:18 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20040721141524.GA12564@kroah.com> <200407232106.41065.rjwysocki@sisk.pl> <20040723200416.GO19329@fs.tum.de>
In-Reply-To: <20040723200416.GO19329@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407232322.18882.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 of July 2004 22:04, Adrian Bunk wrote:
> On Fri, Jul 23, 2004 at 09:06:40PM +0200, R. J. Wysocki wrote:
> >...
> > 2. Proposal
> >
> > I propose to introduce a new configuration option CONFIG_UNSUPPORTED,
> > such that if it is not set, the unmaintained/unsupported code will not be
> > compiled into the kernel.  Moreover,
> > * IMO the option should not be set by default, which would require a user
> > action to include the unsupported code into the kernel,
> > * IMO the option should be documented as to indicate that the code marked
> > with the help of it is not supported by kernel developers and may be
> > removed from the kernel at any time without notification.
> >...
>
> Quoting 2.6 MAINTAINERS:
>
> <--  snip  -->
>
> PCMCIA SUBSYSTEM
> L:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
> S:      Unmaintained
>

Sure, but does it mean "It's buggy and may be killed at any time.  And BTW 
don't compile it in if you don't know what you're doing, because it may kill 
your dog and noone will help you - you have been warned"?

The idea is essentially not about saying that something is unmaintained, but 
about marking chunks of code slated for removal in a manner that's clearly 
visible to users.

Yours,
rjw

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
