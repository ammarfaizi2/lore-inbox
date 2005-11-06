Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVKFSR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVKFSR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 13:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVKFSR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 13:17:58 -0500
Received: from ns.firmix.at ([62.141.48.66]:35008 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750965AbVKFSR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 13:17:58 -0500
Subject: Re: New Linux Development Model
From: Bernd Petrovitsch <bernd@firmix.at>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <436CB162.5070100@ed-soft.at>
References: <436C7E77.3080601@ed-soft.at>
	 <20051105122958.7a2cd8c6.khali@linux-fr.org>  <436CB162.5070100@ed-soft.at>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Sun, 06 Nov 2005 19:17:43 +0100
Message-Id: <1131301063.7587.17.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-05 at 14:19 +0100, Edgar Hucek wrote:
[...]
> Maybe you don't understand what i wanted to say or it's my bad english.
> The ipw2200 driver was only an example. I had also problems with, vmware,
> unionfs...
> What i mean ist, that kernel developers make incompatible changes to the 
> header

ACK. The reason is the improve the kernel and drivers.

> files, change structures, interfaces and so on. Which makes the kernel 
> releases incompatible.

ACK. It needs (a lot of) work to keep backwards compatibility and who
wants can do it (probably).
At what to do at the point where you actually have to break it?

> There are several reasons why modules are not in the mainline kernel and 
> will never
> get there. So saying, bring modules to the kernel is wrong.

The last conclusion doesn't hold. Especially not in this general form.
You have to list the "various reaons" and then we can discuss each of
them.

> The right way would be to take care of defined interfaces, header files, 
> and so on.

The only defined interface of the kernel can be found in POSIX, SUSv3
and similar documents.

> Otherwise you could only say the kernel 2.6.14 is only compatible to 
> 2.6.14.X and
> you there is no stable 2.6 mainline kernel.

Compatible in what way? Source? Object? User-space binary interface?

> I think it's also no task for the user, to search the net why external 

Then don't do it.

> driver xyz not
> works with a new kernel ( because of incompatibilties ). Basicly in new 
> kernel there

Who is interested in the new driver/kernel/..?
The user. So guess who's job is to do it (or find someone to do it -
paid or unpaid).

> could be a chance for the user a driver works better, because a bug was 
> fixed in the kernel.
> Hopefully this time it's more clear why i blame the development process 
> and i'm a so frustrated linux user.

Who do you mean with "user"? 
A typical "user" just installs $DISTRIBUTION (be it a free or commercial
one) and that's it. *If* the bug is severe enough (and the relevant
maintainers does it) there will be a new rpm/deb/... with the newest
kernel release or a backport.
If not, you can do it on your own anyways.
But then you are half a programmer and more like a sys-admin and no
longer a "user". Voila.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



