Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWIGSeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWIGSeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWIGSeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:34:21 -0400
Received: from relay02.pair.com ([209.68.5.16]:30724 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751830AbWIGSeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:34:19 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 7 Sep 2006 13:25:33 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Stuart MacDonald <stuartm@connecttech.com>
cc: "'Chase Venters'" <chase.venters@clientec.com>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>, ellis@spinics.net,
       "'Willy Tarreau'" <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: RE: bogofilter ate 3/5
In-Reply-To: <08b101c6d2a4$04f74020$294b82ce@stuartm>
Message-ID: <Pine.LNX.4.64.0609071307000.31500@turbotaz.ourhouse>
References: <08b101c6d2a4$04f74020$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Stuart MacDonald wrote:

> From: Chase Venters [mailto:chase.venters@clientec.com]
>> highly ironic that spam blocker services tell you not to use certain
>> techniques (autoresponders, bounce messages) that are not only
>> commonplace, but precedented and even mandated by RFC on the
>> grounds that
>> they may cause you to be blocked. Then they move on to
>> criticize anti-spam
>> techniques that fall in these domains with one of their
>> subpoints saying
>> 'they can cause you to miss legitimate mail!'
>>
>> Guess what: so does indiscriminately blocking people whose
>> sites don't bow
>> down to your unreasonable demands, especially when their
>> behavior (say,
>> sending bounce messages) is described in the official protocol
>> documentation.
>
> I will assume you are referring to SpamCop. Their service does not
> behave the way you think it does:
> http://forum.spamcop.net/forums/index.php?autocom=custom&page=whatis
> Read the paragraph: "SpamCop works exactly like the credit reporting
> agencies..."
>

What are you implying - that SpamCop doesn't make decisions about who to 
block and who to not block for third parties? Their weasel wording 
comparing themselves to credit reporting is pretty weak and doesn't stand
a chance of obscuring their purpose, methods or results from anyone with half
a clue. But let's pretend that it did for just long enough that I can 
point out that because of the coercive nature of credit agency decisions, 
they are expected to behave reasonably as well. Saying, "but the creditors 
are making the decisions and we're just providing data!" is no excuse for 
credit reporting agencies to, say, give low credit scores to people who 
live in a certain part of town, or practice a certain religion, or happen 
to have skin of a certain color.

I will strongly criticize any service that purports to label senders of 
automatic responses as senders of unsolicited mail. The response sent by 
an autoresponder (be it a deferral, bounce, vacation or mailing list 
manager message) is most definitely solicited. The fact that Internet mail 
is broken enough to allow terribly easy envelope forgery does not change 
this fact. Trying to defer responsibility for a misdirected automatic 
response to the program or party using the program that sent it is like 
trying to blame gun manufacturers for specific instances of murder; it's 
absurd and it misses the point.

Whether or not SpamCop servers actually drop any messages is irrelevant 
when they are providing purportedly reputable data to third parties who 
use it to decide whether or not to drop messages themselves. The sad fact 
is that most postmasters just aren't educated enough about these issues to 
see through the glossy marketing materials RBLs and other services use to 
promote their wares.

And on the specific issue of autoresponders, I think a reasonable 
compromise is to support DomainKeys. That way if a sender is irritated 
that they are receiving automatic responses from messages they didn't 
send, they can personally take action to invalidate the forgery.

But mark my words: Asking hosts to stop sending bounce messages or 
automatic responses is insane and contrary to over a decade of established 
postmaster precedent.

>
> ..Stu
>

Thanks,
Chase
