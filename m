Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbUKIVPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUKIVPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUKIVPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:15:24 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:51213 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S261685AbUKIVNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:13:33 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Dmitry Torokhov'" <dtor_core@ameritech.net>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       <davids@webmaster.com>,
       "=?iso-8859-1?Q?'Rapha=EBl_Rigo_LKML'?=" <lkml@twilight-hall.net>
Subject: RE: GPL Violation of 'sveasoft' with GPL Linux Kernel/Busybox +code
Date: Tue, 9 Nov 2004 16:13:31 -0500
Organization: Connect Tech Inc.
Message-ID: <000001c4c6a0$f71bfc90$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <1099993648.15462.8.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alan Cox
> On Maw, 2004-11-09 at 02:32, Dmitry Torokhov wrote:
> > "The $20 USD subscription fee includes unlimited priority support,
> > full access to the Sveasoft forums, and unlimited access to new
> > firmware versions and upgrades."
> > 
> > So it looks like "if you exersize your right for the 
> software in quesion
> > I terminate the contract we have entered into" as opposed 
> to "I will not
> > extend your contract beyond initial term".
> > 
> > Isn't that an additional restriction? My rights for updates 
> are revoked
> > if I distribute GPLed code.
> 
> Those aren't GPL granted rights. The updates/support contract is a
> private contractual matter between Sveasoft and its members. 
> They don't
> stop you redistributing the GPL code you received.

Two things:

First. As a lurker I've seen the previous sveasoft discussion, but
didn't delve into it. I've followed this thread more closely. I've
seen the arguments, and *as they stand* it seems to me that sveasoft
must be in violation. However, someone pointed out this:
http://www.sveasoft.com/modules/phpBB2/viewtopic.php?t=3033
If the compliance guy thinks they're ok, then likely there's something
I'm missing. What could that be?

A quick look around their forums popped up this:
http://www.sveasoft.com/modules/phpBB2/viewtopic.php?t=3868
which says in short they will only revoke subscriptions if they find
you redistributing the *non-GPL* portions of the pre-release software.
Presumably they've licenced their pre-release non-GPL bits under a "We
will revoke your licence if you redistribute this bit" licence. Which
is fair. The author of a work is free to licence it however they see
fit, irregardless if they've previously licenced earlier versions
under the GPL.

So it seems they are in compliance after all. Just that the thread is
a little misleading about what's going on, and that confused me for a
bit.

Second. Let's assume for a minute that they are revoking subscriptions
if you redistribute the GPL bits, which is your right. Alan and others
appear to be saying above that this is okay. I disagree.

The GPL protects your right to redistribute from "further
restriction". It does not specify in what manner this restriction may
take place; specifically it does not say that the "further
restriction" must be something described in the GPL. In my reading,
the further restriction could take any form whatsoever.

Ah, something just clicked. I think Alan is reading the "rights
herein" part, and then saying above that the right to support, updates
etc is not a GPL-granted right, and thus is not subject to the
protection of that clause. Fair enough, they are not. However, **that
is not the right being restricted** in this now-hypothetical scenario.

In the hypothetical, sveasoft would be penalising you for exercising
your right to redistribute the GPL code. The fact that this
penalisation is taking the form of revoking some other right between
you and they is irrelevant. They could just as easily have penalised
you by beating you with a stick.

How can a penalisation not be a "further restriction" on your right to
redistribute?

My reading of the GPL tells me that "further restriction" means
**any** restriction whatsoever, whensoever, howsoever. If there is a
sentence of the form

if (exercise(GPL-protected-right))
  penalise(method);

that is a further restriction. What "method" is, how it operates, when
it comes into force is irrelevant.

That's my understanding. Am I correct? Or not?

..Stu

