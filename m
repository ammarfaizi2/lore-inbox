Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVL2Xxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVL2Xxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVL2Xxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:53:53 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:53680 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751159AbVL2Xxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:53:53 -0500
Message-ID: <43B46078.1080805@wolfmountaingroup.com>
Date: Thu, 29 Dec 2005 15:17:28 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B453CA.9090005@wolfmountaingroup.com> <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 29 Dec 2005, Jeff V. Merkey wrote:
>  
>
>>The breakage issue is ridiculous, assinine, and unnecessary. I have been
>>porting dsfs to the various releases over the past month, and the
>>breakage of user space, usb, nfs, memory management, is beyond absurd.
>>    
>>
>
>We're not talking about internal kernel stuff. Internal kernel stuff 
>_does_ get changed, and we dont' care about breakage of out-of-kernel 
>stuff. That's fundamental.
>  
>

Start caring. People spend lots of money supporting you, and what you 
are doing. How about taking some
responsibility for that so they don't change their minds and move back 
to windows or pull their support because it's too
costly or too much of a hassle to produce something stable from these 
releases. If you export functions from the kernel,
don't break them. Don't let these numbnuts keep breaking things that 
shouldn't be broken, i.e. memory manager (now that's a
big one). If you replace a subsystem with a newer one, keep a mapping 
layer through at least the next .<even> release
i.e. 2.4 -> 2.6 (this is reasonable and expected -- you can drop things 
but you should only do it on well understood
boundries). Don't let these people break everything every other 
incremental release.

I have a family too Linus and I like to spend my evenings with them 
rather then unwinding Olaf's bugs in NFS (the most
recent one). Think about "free and easy" and about making peoples lives 
a little easier to support code on your platform
rather then expecting the rest of the planet to clean up everyone's 
messes and sloppiness.

Jeff





>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

