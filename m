Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVEYRRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVEYRRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVEYRRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:17:44 -0400
Received: from one.firstfloor.org ([213.235.205.2]:30091 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261496AbVEYRRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:17:37 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven Dietrich <sdietrich@mvista.com>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <1116957953.31174.37.camel@dhcp153.mvista.com>
	<20050524224157.GA17781@nietzsche.lynx.com>
	<1116978244.19926.41.camel@dhcp153.mvista.com>
	<20050525001019.GA18048@nietzsche.lynx.com>
	<1116981913.19926.58.camel@dhcp153.mvista.com>
	<20050525005942.GA24893@nietzsche.lynx.com>
	<1116982977.19926.63.camel@dhcp153.mvista.com>
	<20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	<20050524192029.2ef75b89.akpm@osdl.org>
	<20050525063306.GC5164@elte.hu>
From: Andi Kleen <ak@muc.de>
Date: Wed, 25 May 2005 19:17:36 +0200
In-Reply-To: <20050525063306.GC5164@elte.hu> (Ingo Molnar's message of "Wed,
 25 May 2005 08:33:06 +0200")
Message-ID: <m1br6zxm1b.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Andrew Morton <akpm@osdl.org> wrote:
>
>> Sven Dietrich <sdietrich@mvista.com> wrote:
>> >
>> > I think people would find their system responsiveness / tunability
>> >  goes up tremendously, if you drop just a few unimportant IRQs into
>> >  threads.
>> 
>> People cannot detect the difference between 1000usec and 50usec 
>> latencies, so they aren't going to notice any changes in 
>> responsiveness at all.
>
> i agree in theory, but interestingly, people who use the -RT branch do 
> report a smoother desktop experience. While it might also be a 

I bet if you did a double blind test (users not knowing if they
run with RT patch or not or think they are running with patch when they
are not) they would report the same. 

Basically when people go through all that effort of applying
a patch then they really want to see an improvement. If it is there
or not.

You surely have seen that with other patches when users
suddenly reported something worked better/smoother with a new
release etc and there was absolutely no explanation for it in the changed
code.

I have no reason to believe this is any different with all
this RT testing. 

-Andi (who also would prefer to not have interrupt threads, locks like
a maze and related horribilities in the mainline kernel) 

