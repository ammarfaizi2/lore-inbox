Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbVLEX4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbVLEX4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbVLEX4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:56:10 -0500
Received: from mail-haw.bigfish.com ([12.129.199.61]:2936 "EHLO
	mail25-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751495AbVLEX4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:56:09 -0500
X-BigFish: V
Message-ID: <4394D396.1020102@am.sony.com>
Date: Mon, 05 Dec 2005 15:56:06 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <200512051826.06703.andrew@walrond.org>	 <1133817575.11280.18.camel@localhost.localdomain>	 <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain>
In-Reply-To: <1133819684.11280.38.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> I think it's time to recognise that there's no difference in licensing
> terms between EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL().

I disagree.  I think that has long since become the intent
of EXPORT_SYMBOL_GPL().

If the GPL covers interface linkages (whether static or
dynamic) then EXPORT_SYMBOL_GPL is redundant.  If it does
not, in all cases, then EXPORT_SYMBOL_GPL is, as
an extension to GPL, therefore a GPL violation.

I believe there are cases where an interface could
be deemed not coverable by the GPL.  Putting
EXPORT_SYMBOL_GPL around it would be an attempt
to extend GPL to where it otherwise might not reach.

DISCLAIMER: I'm not speaking for Sony here. Personally
I don't believe that most drivers are derivative works
of the operating systems they run with, and I don't
believe it helps Linux to assert that they are.
But, hey, it's not my kernel, and not my plan for
world domination. ;-)

To the larger argument about supporting binary drivers,
all Arjan manages to prove with his post is that,
if handled in the worst possible way, support for
binary drivers would be a disaster.  Who can disagree
with that?

(I'm really not trolling or trying to start a flame
war here.  It's just my 2 cents.)

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

