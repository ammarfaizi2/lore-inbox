Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVECQWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVECQWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVECQWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:22:48 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:45965 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261179AbVECQWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:22:30 -0400
Message-ID: <4277A208.8000309@tmr.com>
Date: Tue, 03 May 2005 12:08:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
References: <m31x8q8bc5.fsf@lugabout.cloos.reno.nv.us><20050430164303.6538f47c.akpm@osdl.org> <20050501222630.2fed0bd7.akpm@osdl.org>
In-Reply-To: <20050501222630.2fed0bd7.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> James Cloos <cloos@jhcloos.com> wrote:
> 
>>Apologies if this has already been asked and I missed it, but do you
>>expect to transition to exporting your working tree via git, now that
>>licensing concerns are not part of the equation?
>>
> 
> 
> Nope.  At any particular point in time the tree I have here has lots of
> problems - failing to compile, crashing, etc.  It takes me from four hours
> to three days just to get a halfway-respectable release out the door.
> 
> So there's no way in which I'd want to make the tree-of-the-minute
> externally available - it would muck people around too much and would cause
> me to get a ton of email about stuff which I'd probably already fixed.
> 
> That, plus a traditional SCM is an inappropriate format for something like
> -mm.  This tree is a series of patches against Linus's tree - that's how it
> is developed, tested and sent upstream.  Patches get added, dropped,
> reordered and merged at any time.  It's hard to explain - you need to have
> used patch-scripts or quilt for a while...
> 
> Prematurely flattening all this into an SCM view is a fairly pointless
> exercise - the only reason for doing it would be for people to be able to
> download it.  And they can do that by grabbing the single diff anyway.  I
> suppose someone might start offering git -mm trees sometime, as an
> alternative to grabbing the diff file.

For all of the reasons you describe putting up your tree would be a 
waste of time, and putting up another tree is likely to only result in 
duplicated effort; the folks who want SCC can use whatever works for 
them and then send you patches.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

