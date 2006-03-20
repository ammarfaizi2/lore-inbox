Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWCTWTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWCTWTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWCTWTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:19:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53192 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751254AbWCTWTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:19:23 -0500
Date: Mon, 20 Mar 2006 23:18:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Peter Wainwright <prw@ceiriog.eclipse.co.uk>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announcing crypto suspend
Message-ID: <20060320221828.GJ24523@elf.ucw.cz>
References: <20060320080439.GA4653@elf.ucw.cz> <200603202126.23861.rjw@sisk.pl> <20060320203507.GF24523@elf.ucw.cz> <200603202222.14634.rjw@sisk.pl> <20060320213400.GI24523@elf.ucw.cz> <441F2727.6020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441F2727.6020407@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 21-03-06 00:05:27, Alon Bar-Lev wrote:
> Pavel Machek wrote:
>  > Of course, agreed. Encrypting filesystem is stupid thing from
> > data-recovery standpoint; and I care about my data; it is also hard to
> > backup. For some uses it is of course neccessary, but it has lots of
> > disadvantages, too.
> 
> Pavel, you keep doing the same basic mistake...
> Understand your client!
> 
> Suspend is a feature that is most used by the mobile community.
> Disk encryption is also common for most of this community.
> Putting them to work together should be your interest...
> Calling your clients stupid is not wise!

Are you trying to flame me or is it that you can't understand english?

I never claimed my users are stupid. Read that sentence again.

> > Encrypted swsusp has basically no disadvantages.
> > 
> > [I believe we should encrypt swap with random key generated on boot by
> > default. That should be also very cheap, and has no real
> > disadvantages].
> 
> Well... Good thinking... But how do you plan to encrypt the
> swap? There are about 1000 ways to do this...

Yep, but one good enough way is ... well ... enough.

> Jari Ruusu had written the loop-aes which was not merged...
> >From a similar reason suspend2 was rejected by you.

suspend2 was never submitted in the first place.

> I hope you don't think that file-system encryption should be
> implemented in user mode too...

Don't put words into my mouths.

> The dm-crypt is weak... So we left with specific encryption
> implementation of swsusp... And now you offer a specific
> encryption for swap as well... Why not realize that there
> should be one encryption solution for block devices in kernel?

Why not working on that solution instead of flaming me? Last time I
seen, it was not quite easy to work with Jari.
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
