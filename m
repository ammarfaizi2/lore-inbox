Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263994AbTCWXXE>; Sun, 23 Mar 2003 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263995AbTCWXXE>; Sun, 23 Mar 2003 18:23:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49852 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263994AbTCWXXC>;
	Sun, 23 Mar 2003 18:23:02 -0500
Message-ID: <3E7E4486.8080302@pobox.com>
Date: Sun, 23 Mar 2003 18:34:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Stephan von Krawczynski <skraw@ithnet.com>,
       szepe@pinerecords.com, arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <20030323203628.GA16025@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca> <920000.1048456387@[10.10.2.4]> <3E7E335C.2050509@pobox.com> <1240000.1048460079@[10.10.2.4]>
In-Reply-To: <1240000.1048460079@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>akpm has suggested something like this in the past.  I respectfully
>>disagree.
>>
>>The 2.4 kernel will not benefit from constant churn of backporting core
>>kernel changes like a new scheduler.  We need to let it settle, simply
>>get it stable, and concentrate on fixing key problems in 2.6.  Otherwise
>>you will never have a stable 2.4 tree, and it will look suspiciously more
>>and more like 2.6 as time goes by.  Constantly breaking working
>>configurations and changing core behaviors is _not_ the way to go for 2.4.
>>
>>I see 2.4 O(1) scheduler and similar features as _pain_ brought on the
>>vendors by themselves (and their customers).
> 
> 
> O(1) sched may be a bad example ... how about the fact that mainline VM
> is totally unstable? Witness, for instance, the buffer_head stuff. Fixes
> for that have been around for ages. 

"totally unstable" being defined as:  My computers don't crash, and my 
100%-mainline test kernels pass various Cerberus/LTP/crashme runs.

Of course, I am not totally focused on multi-million-dollar computers, 
so maybe my perspective is skewed...  ;-)


> The real philosophical question is "what is mainline 2.4 _for_"?

It's the 2.4 tree that's missing all the vendor junk unacceptable for 
mainline.


> Yes, the real answer is to get 2.6 out the door, and move people onto it.
> But that will take a little while ... would be nice to get some way to
> alleviate the pain in the meantime.

Fixes should be applied to 2.4-mainline, certainly.  Anything else just 
wastes developer brain cycles and slows the move to 2.6.

	Jeff



