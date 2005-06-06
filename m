Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVFFVyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVFFVyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVFFVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:54:28 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47632 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261708AbVFFVw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:52:56 -0400
Message-ID: <42A4C617.8030404@tmr.com>
Date: Mon, 06 Jun 2005 17:54:31 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050606192654.GA3155@elf.ucw.cz> <42A4AA01.90905@pobox.com> <20050606200512.GF2230@elf.ucw.cz> <Pine.LNX.4.58.0506061407520.1876@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506061407520.1876@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 6 Jun 2005, Pavel Machek wrote:
> 
>>Linus, perhaps your scripts are doing something wrong? They should
>>have taken From in the description; or did I provide wrong changelog?
> 
> 
> My scripts definitely do the expected thing. 
> 
> In git, the author is always in the fixed header, and you never look for
> it anywhere else. However, in order for the author to _get_ there in the
> first place, the person who commits the thing needs to haev the author
> info.
> 
> In this case it was me, and I get the author information from the email
> when I commit an emailed patch. I take it from the first line of the body
> if that one is a valid "From:" line, and otherwise I fall back to taking
> it from the headers of the email.
> 
> So in this case you got tagged, either because the patch came through
> Andrew (it has his sign-off) and _he_ sent the email but incorrectly had
> you as the "From:" person, or alternatively because you sent the email and
> took Andrew's sign-off but didn't put the "From:" in the right spot.

Any process which only works when multiple people do everything 
correctly is not going to be robust. Perhaps you want to use the first 
"signed-off-by" line or some such, rather than relying on mail headers?
