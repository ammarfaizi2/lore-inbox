Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWGJRY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWGJRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWGJRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:24:58 -0400
Received: from javad.com ([216.122.176.236]:47368 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1422717AbWGJRY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:24:57 -0400
From: Sergei Organov <osv@javad.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org> <87veq9cosq.fsf@javad.com>
	<1152302831.20883.63.camel@localhost.localdomain>
	<87d5cdg308.fsf@javad.com>
	<1152529855.27368.114.camel@localhost.localdomain>
	<873bd9fobb.fsf@javad.com>
	<1152552683.27368.185.camel@localhost.localdomain>
Date: Mon, 10 Jul 2006 21:24:40 +0400
In-Reply-To: <1152552683.27368.185.camel@localhost.localdomain> (Alan Cox's
	message of "Mon, 10 Jul 2006 18:31:23 +0100")
Message-ID: <87sll9e5k7.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> Ar Llu, 2006-07-10 am 19:54 +0400, ysgrifennodd Sergei Organov:
>> Wow! The code you've quoted seems to be correct! But where did you get
>> it from? The version of flush_to_ldisc() from drivers/char/tty_io.c from
>> 2.17.4 got last Friday from kernel.org does this:
>
>>From HEAD so it should make 2.6.18. Paul fixed this one.

Great news, -- the time I can finally throw away my ugly work-around is
coming!

Thank you a lot for clarifying the issue!

-- 
Sergei.
