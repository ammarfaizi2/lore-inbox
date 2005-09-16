Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965315AbVIPTx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965315AbVIPTx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965314AbVIPTx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:53:27 -0400
Received: from smtpout.mac.com ([17.250.248.46]:1267 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965316AbVIPTx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:53:26 -0400
In-Reply-To: <432B1F84.3000902@namesys.com>
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org> <432B1F84.3000902@namesys.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1C909C65-8B71-4817-AE13-519599D0B11A@mac.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Fri, 16 Sep 2005 15:52:45 -0400
To: Hans Reiser <reiser@namesys.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC list trimmed to relevant people, no need to spam Linus' and  
Andrew's mailboxes, they have enough to do as it is]

On Sep 16, 2005, at 15:39:48, Hans Reiser wrote:
> Christoph Hellwig wrote:
>> additinoal comment is that the code is very messy, very different
>> from normal kernel style, full of indirections and thus hard to read.
>
> Most of my customers remark that Namesys code is head and shoulders
> above the rest of the kernel code.  So yes, it is different.

And yet thousands and thousands of people, businesses, etc, say that  
the Linux kernel code is miles above all the commercial software out  
there. Please leave the worthless rhetoric out of a technical  
discussion.  The issue stands that in many ways the Reiser4 code does  
not exactly follow Documentation/CodingStyle and does not match most  
of the rest of the kernel, making it hard to read for other kernel  
developers.  If you were just doing this forever as an external  
kernel patch, nobody would give a damn.  On the other hand, you're  
trying to get it included in the upstream kernel, which means that  
those same "other kernel developers" for whom it is hard to read may  
be expected to maintain it until the end of time.  Given this, it  
seems perfectly reasonable to ask that it be cleaned up.

> In particular, they cite the XFS code as being so incredibly hard  
> to read that its unreadability is worth hundreds of thousands of  
> dollars in license fees for me.

How does XFS have _anything_ to do with Reiser4?  A technical  
discussion is no place for political pissing contest.

> [more useless posturing snipped]

> As for the indirections, if you figure out how to make VFS  
> indirections easy to follow, the same technique should be  
> applicable to Reiser4, and I will be happy to fix it.

That's not his responsibility, it's _yours_.  If you want your stuff  
included in the the kernel, you need to make sure it is sufficiently  
acceptable.  Besides, this is just one complaint of the many he  
made.  This may not be particularly solvable, but there are a number  
of other points he made that you guys need to try to resolve.

> (Note for the record: I actually think XFS acceptance was delayed  
> too long, and I think that XFS is a great filesystem, but a  
> rhetorical point needed to be made......)

See above.  Rhetoric has little or no place here.  Such comments are  
why Reiser4 typically triggers massive flamewars when it is mentioned  
on the LKML.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Shultz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Shultz


