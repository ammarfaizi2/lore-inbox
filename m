Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751758AbWHSQEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbWHSQEt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWHSQEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:04:49 -0400
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:55057 "EHLO
	smtp-vbr16.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751758AbWHSQEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:04:48 -0400
Message-ID: <44E7369D.2010707@xs4all.nl>
Date: Sat, 19 Aug 2006 18:04:45 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mike Galbraith <efault@gmx.de>,
       Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: And another Oops / BUG? (2.6.17.8 on VIA Epia CL6000)
References: <44E29415.4040400@xs4all.nl> <1155713739.6011.30.camel@Homer.simpson.net>
In-Reply-To: <1155713739.6011.30.camel@Homer.simpson.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Wed, 2006-08-16 at 05:42 +0200, Udo van den Heuvel wrote:
>> Again my CL6000 Oopsed.
>>
>> How can I proceed to find the cause?
>>
> (these oopsen would be a heck of a lot easier to look at if the
> timestamp junk was stripped off)

Will try to do that next time.

> The oops doesn't help much.  Once again, eip is in lala land, not the
> kernel.

Hmm. At least that is consistent, as is the named involvement and the
rest of the effects.

> Given that you're the only person posting this kind of explosion, I
> would cast a very skeptical glance toward my hardware.  I'd suggest
> reverting to a known good kernel first, to verify that you really don't
> have a hardware problem cropping up.

How long should I run a 2.6.16.* kernel to be sure enough it is not my
hardware?

> After I did that, I'd enable stack check thingies under kernel hacking,
> and if that didn't turn up anything, I'd try slab and page allocator
> debugging options and hope to catch someone scribbling where they're not
> supposed to.

OK, will try that.
