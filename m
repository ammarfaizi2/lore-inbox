Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWCIQFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWCIQFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWCIQFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:05:04 -0500
Received: from dvhart.com ([64.146.134.43]:12209 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751151AbWCIQFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:05:03 -0500
Message-ID: <44105227.8020503@mbligh.org>
Date: Thu, 09 Mar 2006 08:04:55 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org> <200603062124.42223.jesper.juhl@gmail.com> <20060306203036.GQ4595@suse.de> <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com> <20060306215515.GE11565@redhat.com> <44104EB7.9090103@mbligh.org> <20060309155437.GE5410@kvack.org>
In-Reply-To: <20060309155437.GE5410@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Thu, Mar 09, 2006 at 07:50:15AM -0800, Martin J. Bligh wrote:
> 
>>Do we NOT want to have DEBUG_SLAB and DEBUG_PAGEALLOC both enabled?
>>Running multiple permutations is going to get really painful on the
>>systems involved. Any other requests for what gets enabled (I really
>>want to just stick to one 'debug' setup if possible).
> 
> 
> Debug kernels are incredibly slow, making hitting certain races next to 
> impossible.  By all means non-DEBUG kernels should definately be getting 
> tested.

It'd still run a totally non-debug kernel as well - I want that for the
perf tests etc anyway. I guess the question is whether the debug kernels
should have most of the DEBUG_* turned on, or just a select few.

M.
