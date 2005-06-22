Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVFVBi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVFVBi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVFVBi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:38:26 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:61847 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262448AbVFVBiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:38:14 -0400
Message-ID: <42B8C0FF.2010800@namesys.com>
Date: Tue, 21 Jun 2005 18:38:07 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Alexander Lyamin aka FLX <flx@namesys.com>
CC: Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de>
In-Reply-To: <20050621195642.GD14251@wotan.suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Tue, Jun 21, 2005 at 11:44:55AM -0700, Hans Reiser wrote:
>  
>
>>vs and zam, please comment on what we get from our profiler and spinlock
>>debugger that the standard tools don't supply.  I am sure you have a
>>reason, but now is the time to articulate it.
>>
>>We would like to keep the disabled code in there until we have a chance
>>to prove (or fail to prove) that cycle detection can be resolved
>>effectively, and then with a solution in hand argue its merits.
>>    
>>
>
>How about the review of your code base? Has reiser4 ever been
>fully reviewed by people outside your group? 
>
>Normally full review is a requirement for merging.
>  
>
V4 has a mailing list, and a large number of testers who read the code
and comment on it.   V4 has been reviewed and tested much more than V3
was before merging.   Given that we sent it in quite some time ago, your
suggestion that an additional review by unspecified additional others be
a requirement for merging seems untimely.  Do you see my point of view
on this?

I would however enjoy receiving coding suggestions at ANY time.  We
don't get as much of that as I would like.   I would in particular love
to have you Andi Kleen do a full review of V4 if you could be that
generous with your time, as I liked much of the advice you gave us on V3. 

Unspecified others doing a review, well, who knows, I will surely take
the time to consider what is said by them though..... 

I would prefer to not get reviews from authors of other filesystems who
prefer their own code, skim through our code without taking the time to
grok our philosophy and approach in depth, and then complain that our
code is different from what they chose to write, and think that our
changing to be like them should be mandated.  I will not name names here....

Some of the suggestions on our mailing list are great, some reflect a
lack of 5 years working with our code, perhaps I should feed our mailing
list into the linux kernel mailing list so that people on the kernel
mailing list are more aware that we exist and are active?

>-Andi
>
>
>  
>

