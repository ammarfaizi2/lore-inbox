Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWC1XKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWC1XKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWC1XKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:10:44 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:32837 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964817AbWC1XKn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:10:43 -0500
Message-ID: <4429B8EC.3040008@tmr.com>
Date: Tue, 28 Mar 2006 17:30:04 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
References: <20060320212338.GA11571@kroah.com> <dvt4rl$2b8$1@sea.gmane.org> <20060323212945.GE22727@stusta.de>
In-Reply-To: <20060323212945.GE22727@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Mar 23, 2006 at 12:33:13PM +0900, Kalin KOZHUHAROV wrote:
>> Greg KH wrote:
>>> They are the same "delete devfs" patches that I submitted for 2.6.12 and
>>> 2.6.13 and 2.6.14 and 2.6.15.  It rips out all of devfs from the kernel
>>> and ends up saving a lot of space.  Since 2.6.13 came out, I have seen
>>> no complaints about the fact that devfs was not able to be enabled
>>> anymore, and in fact, a lot of different subsystems have already been
>>> deleting devfs support for a while now, with apparently no complaints
>>> (due to the lack of users.)
>>>
>>> It's also been over 8 months past the date when we said we would delete
>>> devfs from the kernel tree in the file,
>>> Documentation/feature-removal-schedule.txt, and over one and one half
>>> years since we publicly announced to the world that devfs would be
>>> removed from the kernel tree.  So, I think people have had plenty of
>>> advance notice that this was going to happen by now :)
>>>
>>> Please pull from:
>>> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
>>> or if master.kernel.org hasn't synced up yet:
>>> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
>>>
>>> I've posted all of these patches before, but if people really want to look at them, they can be found at:
>>> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
>>>
>>> Also, if people _really_ are in love with the idea of an in-kernel
>>> devfs, I have posted a patch that does this in about 300 lines of code,
>>> called ndevfs.  It is available in the archives if anyone wants to use
>>> that instead (it is quite easy to maintain that patch outside of the
>>> kernel tree, due to it only needing 3 hooks into the main kernel tree.)
>> OK, I completely agree with that, but shouldn't there be left something in
>> the Documentation at least? A note like "devfs was superseded by udev since
>> 2.6.?? and was completely removed since 2.6.??" or something along the same
>> line of thought? It will just make life easier for people finding lots of
>> old pages and HOWTOs on the Net mentioning devfs.
>>
>> Unfortunately I couldn't find a proper place for that note...
>> Maybe a new file Documentation/filesystems/devfs.txt instead of the 
>> Documentation/filesystems/devfs directory present now?
> 
> There's already a note in Documentation/Changes.

I really don't think that's the most likely place people would look. The 
suggested few lines in a file with a dead-obvious name would undoubtedly 
save people time, as they would look there first.

No complaint about getting rid of the feature, but there are lots of 
mentions of devfs, putting in a definitive explanation wouldn't be out 
of place.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

