Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUH0V2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUH0V2Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUH0VYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:24:52 -0400
Received: from mail.dif.dk ([193.138.115.101]:10217 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268013AbUH0VTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:19:44 -0400
Date: Fri, 27 Aug 2004 23:25:27 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Summarizing the PWC driver questions/answers
In-Reply-To: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
Message-ID: <Pine.LNX.4.61.0408272259450.2771@dragon.hygekrogen.localhost>
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Kenneth Lavrsen wrote:

> At 18:26 2004-08-27, you wrote:
> 
> > First off, here's Nemosoft's big post about the driver, please read that
> > first, and the responses to that thread:
> > http://thread.gmane.org/gmane.linux.usb.devel/26310
> 
> Reading the thread (which I already did) shows even more clearly that what you
> did is wrong.
> The hook and the functionality of pwc/pwcx has been in the kernel for years.
> People like myself have invested quite much money on cameras - assuming that
> no evil person would remove the support of an existing hardware from the Linux
> kernel once the support had been added.
> What you did is WRONG. You may have the rights to do it. But it is WRONG. Once
> the support has been added it is wrong to remove it without replacing it with
> something else.
> 
Assuming that any hardware support that gets added will be there forever 
in some form of another is incredibly naive in my oppinion. And this goes 
for any operating system, not just Linux - hardware support has been 
dropped from several different operating systems over the years for lots 
of different reasons - I have boxes where I can't run the latest version 
of AIX any more since the hardware is no longer supported, but you don't 
see me ripping IBM's head off for that reason.


> > Q: Why did you remove the hook from the pwc driver?
> > A: It was there for the explicit purpose to support a binary only
> >    module.  That goes against the kernel's documented procedures, so I
> >    had to take it out.
> 
> You did not HAVE TO remove the hook. It had been there for years. You could
> have worked out an alternative way nice and quietly with the module developer.
> If someone came with a new driver it was something else because no-one would
> be depending on it.
> 
As I understand it the hook should never have been added in the first 
place. Doesn't matter if it has been there for a day, a week, a year or 10 
years - it should never have been added and once it was discovered it was 
removed - I have no trouble with that bit, especially since the pieces 
are still out there and you are free to just patch your personal kernel in 
any way you please to get the result you desire, or you can just stick 
with an older kernel until a suitable alternative shows up.


> This is much more than just a camera thing. This is about commitment. Does the
> Linux and open source community commit to support the hardware and software to
> buy or invest money on developing? Or can a fanatic with ideas destroy
> everything. There are people that have built a business making cost effective
> surveillance systems with Linux and USB cameras using Motion. There will be no
> more support of their boxes anymore because of you. I wonder what names they
> give you now.
> 
And why is it you expect open source developers to assist in supporting 
binary only drivers?
Binary only drivers undermine open source. If you want to depend on closed 
drivers go ahead, but if that support disappears then take it up with the 
company unwilling to provide open drivers or open specs so people can 
write their own open drivers.
You purchased a piece of hardware that depended on a closed source driver, 
no open source developer has any resonable commitment to support that.

If you want to be constructive instead of just bitch and moan, then go 
talk to Philips and get them to release code or specs so we can get proper 
open source drivers - your real beef is with them, not with open source 
developers.


-- 
Jesper Juhl <juhl-lkml@dif.dk> 

Oppinions expressed are only my own, and do not nessesarily reflect those 
of my employer.
--


PS. I'm wondering why you asked Linus a whole host of questions yet did 
not even CC the man on your email.



