Return-Path: <linux-kernel-owner+w=401wt.eu-S965133AbWLOVaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWLOVaL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWLOVaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:30:11 -0500
Received: from lazybastard.de ([212.112.238.170]:35724 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133AbWLOVaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:30:09 -0500
Date: Fri, 15 Dec 2006 21:27:24 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
       Scott Preece <sepreece@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/v2] CodingStyle updates
Message-ID: <20061215212724.GB317@lazybastard.org>
References: <20061207165508.e6bf0269.randy.dunlap@oracle.com> <20061215120942.GA4551@ucw.cz> <4582AEC8.7030608@s5r6.in-berlin.de> <20061215142206.GC2053@elf.ucw.cz> <7b69d1470612150652p609c38d2n9bff58bdb0a1edb7@mail.gmail.com> <20061215150717.GA2345@elf.ucw.cz> <20061215090037.05c021af.randy.dunlap@oracle.com> <20061215201127.GA32210@lazybastard.org> <d120d5000612151256h5428eddcpbd137ce939a58b32@mail.gmail.com> <Pine.LNX.4.61.0612152158240.28506@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0612152158240.28506@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 December 2006 22:01:10 +0100, Jan Engelhardt wrote:
> On Dec 15 2006 15:56, Dmitry Torokhov wrote:
> >
> > Would you write:
> >
> >      i+=2;
> >
> > outside the loop? If not then it is better to keep style consistent
> > and not use condensed form in loops either.
> 
> Don't you all even think about leaving the whitespace away in the wrong
> place, otherwise the kernel is likely to become an entry for IOCCC.

Please, this is not religion.  No god has spoken "though shalt not...".

In 99% of all cases, what Randy wrote is the best choice.  But the
ultimate goal is not to follow his heavenly rules with fundamental
zealotry, the ultimate goal is to make the code readable.  If you
happen to stumble on the 1% case where the code can be more readable by
not following the rules, and you are absolutely sure about that, then
don't.  That simple. ;)

That said, people who are bereft of all common sense have my blessing to
follow the rules literally in their own code.  Just don't stomp over
mine with pitchforks and torches, ok?

Jörn

-- 
I can say that I spend most of my time fixing bugs even if I have lots
of new features to implement in mind, but I give bugs more priority.
-- Andrea Arcangeli, 2000
