Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUGVGOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUGVGOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 02:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUGVGOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 02:14:03 -0400
Received: from dsl081-055-019.sfo1.dsl.speakeasy.net ([64.81.55.19]:42129 "EHLO
	mail.fountainbay.com") by vger.kernel.org with ESMTP
	id S266450AbUGVGN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 02:13:58 -0400
Message-ID: <4546.24.6.231.172.1090476838.squirrel@24.6.231.172>
In-Reply-To: <20040722014649.309bc26f.akpm@osdl.org>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
    <20040721230044.20fdc5ec.akpm@osdl.org>
    <4411.24.6.231.172.1090470409.squirrel@24.6.231.172>
    <20040722014649.309bc26f.akpm@osdl.org>
Date: Wed, 21 Jul 2004 23:13:58 -0700 (PDT)
Subject: Re: [PATCH] Delete cryptoloop
From: "Dale Fountain" <dpf-lkml@fountainbay.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Reply-To: dpf-lkml@fountainbay.com
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton said:
> dpf-lkml@fountainbay.com wrote:
>>
>> Hopefully someone else will follow up, but I hope I'm somewhat
>> convincing:
>
> Not really ;)
>
> Your points can be simplified to "I don't use cryptoloop, but someone else
> might" and "we shouldn't do this in a stable kernel".
>

Well, you're incorrect about my not using cryptoloop. Sorry I wasn't
convincing enough. :)

> Well, I want to hear from "someone else".  If removing cryptoloop will
> irritate five people, well, sorry.  If it's 5,000 people, well maybe not.
>

I don't think you'll get 5000 replies... about anything. ;)

> Yes, I buy the "stable kernel" principle, but here we have an example
> where
> it conflicts with the advancement of the kernel, and we need to make a
> judgement call.
>

I don't buy the "conflicts with the advancement" part, but I'll defer to
your judgement. ;)

>
> Actually, my most serious concern with cryptoloop is the claim that it is
> insufficiently secure.  If this is true then we'd be better off removing
> the feature altogether rather than (mis)leading our users into thinking
> that their data is secure.

I believe 1) the current documentation already notifies people of the
security issues, 2) there are workarounds, and 3) the replacement has
security issues of its own.

Dm-crypt is still unstable, doesn't have all the features of cryptoloop
(please see my previous message), yet you wish to dump cryptoloop? At
least cryptoloop is a known quantity.

Once dm-crypt can be shown to have all the features of the software it's
meant to _replace_, I'll be more likely to agree. Otherwise, it sounds
like this decision is being made on a whim.

Regards,

Dale Fountain

