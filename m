Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbTEGDH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 23:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTEGDH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 23:07:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:23731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262793AbTEGDHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 23:07:55 -0400
Message-ID: <1401.4.64.196.31.1052277628.squirrel@www.osdl.org>
Date: Tue, 6 May 2003 20:20:28 -0700 (PDT)
Subject: RE: PATCH: Replace current->state with set_current_state in 2.5.6 8
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <inaky.perez-gonzalez@intel.com>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C8FDF0C@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780C8FDF0C@orsmsx116.jf.intel.com>
X-Priority: 3
Importance: Normal
Cc: <acme@conectiva.com.br>, <gh@us.ibm.com>, <rddunlap@osdl.org>,
       <devenyga@mcmaster.ca>, <rml@tech9.net>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> From: Arnaldo Carvalho de Melo [mailto:acme@conectiva.com.br]
>>
>> > > And I don't really want to review a 176 KB patch (although I did
> already
>> > > look over most of it a few days ago).  Do people want to take portions
>> of it for review and then see about Alan merging it, e.g.?
>
> As long as they use set_current_state() and not the __ counterpart, then
> they are ok [the memory barrier being to blame for the lost
> performance if any is found].

Yes, last week at least the patch did use set_current_state() almost
exclusively, even when it didn't need to -- most likely.

>> > Hmm.  Has anyone considered a "Kernel Janitor's" tree?  More
> specifically,
>> > a patch set, much like -ac or -mm, with the current cleanups so they can
>> be tested, pulled, run through automated batch testing, etc.?
>>
>> That is an interesting idea, I'll probably start one.

Yay!
Thanks, acme.

~Randy



