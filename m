Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbUJXMkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUJXMkU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 08:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUJXMkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 08:40:20 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:38833 "EHLO
	vsmtp3alice.tin.it") by vger.kernel.org with ESMTP id S261459AbUJXMkJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 08:40:09 -0400
Message-ID: <417BBEFD.9080308@futuretg.com>
Date: Sun, 24 Oct 2004 14:41:01 +0000
From: "Dr. Giovanni A. Orlando" <gorlando@futuretg.com>
Organization: Future Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.6) Gecko/20040626
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org> <4179425A.3080903@namesys.com>
In-Reply-To: <4179425A.3080903@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> Andrew Morton wrote:
>
>>
>>  - reiser4: not sure, really.  The namespace extensions were disabled,
>>    although all the code for that is still present.  Linus's filesystem
>>    criterion used to be "once lots of people are using it, preferably 
>> when
>>    vendors are shipping it".  That's a bit of a chicken and egg thing 
>> though.
>>    Needs more discussion.
>>
>>  
>>
> No distro using reiserfs V3 as the default is going to keep doing so 
> once reiser4 meets their stability requirements. Reiserfs is used by a 
> lot of people, and reiser4 obsoletes it, and the users know that. 

I agree that OS that choose ReiserFS for default now will adopt Reiser4 
instead ReiserFS 3, .... but they need to continue
to support ReiserFS 3 as well Reiser4 ...

In some sense this is equivalent to ext2 and ext3.

Thanks,
Giovanni


> None of the distros have expressed any intent of staying on V3, and 
> they'd be silly to do it. Many of them have expressed a desire to use 
> reiser4. Next year, indications are that reiser4 usage by distros as 
> their default will exceed that which is today possessed by V3. The 
> higher performance of V4 is going to increase our market share.
>
> I would like to encourage its inclusion as an experimental filesystem 
> BEFORE vendors ship it. I think first putting experimental stuff in 
> the kernels used by hackers makes sense. I think it creates more of a 
> community.
>
> I'd like to point out that there is a lot of stuff in the kernel that 
> is a lot less stable than reiser4.
>
> That said, inclusion in -mm found some bugs, and we are still testing 
> one of the fixes which was a bit deep. I want to finish that testing 
> (not more than 7 days) and send you all fixes before asking for 
> inclusion.
>
> Also, Hellwig made a valid point about getting rid of some macros that 
> reduce readability (I also hate code that prevents editors finding 
> called functions), and zam is working on fixing that.
>
> Lindows is planning on shipping with reiser4 in its next release. I 
> would very much like to see our inclusion before that.
>


-- 


-- 
-- 

Check FT Websites ... http://www.futuretg.com  - ftp://ftp.futuretg.com
http://www.FTLinuxCourse.com
    http://www.FTLinuxCourse.com/Certification
http://www.rpmparadaise.org
http://GNULinuxUtilities.com
http://www.YourPersonalOperatingSystem.com

-- 

