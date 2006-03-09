Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWCIPyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWCIPyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWCIPyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:54:23 -0500
Received: from dvhart.com ([64.146.134.43]:9649 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750723AbWCIPyW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:54:22 -0500
Message-ID: <44104FA8.6090604@mbligh.org>
Date: Thu, 09 Mar 2006 07:54:16 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org> <200603062124.42223.jesper.juhl@gmail.com> <20060306203036.GQ4595@suse.de> <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com> <20060306215515.GE11565@redhat.com> <44104EB7.9090103@mbligh.org>
In-Reply-To: <44104EB7.9090103@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> DEBUG_PAGEALLOC in particular is *fantastic* at making bugs hide.
>> I've lost many an hour trying to pin bugs down due to that.
> 
> 
> Is this backwards? We're saying DEBUG_PAGEALLOC is bad?
> 
> OK, what I'm going to try to do, given the recent comments re
> CONFIG_DEBUG_SLAB and also PAGEALLOC is to arrange with Andy to run
> a debug kernel as well as a normal kernel for every test, and then
> we can publish the results on http://test.kernel.org. For now it'll be
> a seperate matrix, until I work out how to fold the 3d cube nicely
> into 2d - I know I have to do that anyway, so no big deal.
> 
> Do we NOT want to have DEBUG_SLAB and DEBUG_PAGEALLOC both enabled?
> Running multiple permutations is going to get really painful on the
> systems involved. Any other requests for what gets enabled (I really
> want to just stick to one 'debug' setup if possible).
> 
> I have no idea why I didn't do this a year ago <slaps self>.

Oh, and I ported CONFIG_DEBUG_PAGEALLOC to x86_64 last week. Will send
out the patch later today.

M.
