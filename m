Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWASXl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWASXl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWASXl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:41:27 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:12969 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750815AbWASXl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:41:27 -0500
Message-ID: <43D023DD.7000609@tmr.com>
Date: Thu, 19 Jan 2006 18:42:21 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Diego Calleja <diegocg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <20060117183916.399b030f.diegocg@gmail.com>
In-Reply-To: <20060117183916.399b030f.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Tue, 17 Jan 2006 00:19:56 -0800 (PST),
> Linus Torvalds <torvalds@osdl.org> escribió:
> 
> 
>>Anyway, it's out there now. The ShortLog is pretty readable - if you are 
>>into that kind of stuff - but as usual for an -rc1 release (which has all 
>>the frantic merging going on), it's actually too big to post on the kernel 
>>list due to the size limits. It's weighs in at 4000+ lines and 169kB.
> 
> 
> Can I ask if it's possible to "mark" new features/important changes?

New features are easy, they usually result in changes to the config 
file. You can learn a lot with "diff" that way.

However, you really need to read the patches to see what they are 
supposed to change. That's a long and thankless job, but it's a wiki, 
right? So ask a few people to just look at parts of it and write 
comments on what they see. Few for filesystems, few for networks, stuff 
like that. And a few to look at "other."

If you do all the work it's not a wiki it's a blog...
> 
> I've maintaining http://wiki.kernelnewbies.org/LinuxChanges
> for three releases and the amount of changes is so big it takes hours 
> to extract the relevant changes, adding some special string in the 
> description field could help to automate this process and make better
> changelogs.
> 
> It's not only better for me, I also know there're more people ej: man
> page maintainers looking at the full changelogs to find out if 
> something has changed. There're lot of nice things being merged on 
> each release, but there's not a way to tell people that those features 
> exist; even kernel developers don't really know what is going on in 
> other parts of the kernel. A "useful" changelog is one of the few
> things the linux kernel has been missing for ages, IMO ;)

