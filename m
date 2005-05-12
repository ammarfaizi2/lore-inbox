Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVELEA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVELEA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 00:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVELEA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 00:00:27 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:53582 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261208AbVELEAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 00:00:21 -0400
Message-ID: <4282D4CA.6030003@yahoo.com.au>
Date: Thu, 12 May 2005 14:00:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Jesper Juhl <juhl-lkml@dif.dk>, "David S.Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace  cleanup)
References: <42Mbg-Tq-25@gated-at.bofh.it> <42MXA-1zI-3@gated-at.bofh.it> <42MXA-1zI-1@gated-at.bofh.it> <42Nh3-1M8-17@gated-at.bofh.it> <42Nh3-1M8-15@gated-at.bofh.it> <E1DW0vK-0000To-IK@be1.7eggert.dyndns.org>
In-Reply-To: <E1DW0vK-0000To-IK@be1.7eggert.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:

>Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
>
>>If Andrew agrees, then I'll commit to doing this cleanup;
>>
>
>>- (to a limited degree) no trailing whitespace
>>
>
>I just ran a script over -rc4 to remove trailing ws. The result is
>about 22 MB in 429 patches (iterated over ./*/*).
>
>How hard can I patch you before you start patching me?
>
>Which addresses am I supposed to send it to? I don't want to break the
>record for the most annoying patch series in lkml.
>

First of all, why is it 429 patches? The patches we want aren't about a
file or a subdirectory or even a subsystem, but they're supposed to be
a logical change. Ie. 1 patch. An exception for something like this would
be if you want to feed it to different maintainers seperately, but it
sounds like you just want to bomb it somewhere...

Secondly, let's not.

More subtle indenting stuff like fixing `if (exp) do_something` I can
understand. But this isn't nearly so helpful.


