Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWBFDjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWBFDjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWBFDjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:39:43 -0500
Received: from smtpout.mac.com ([17.250.248.88]:13300 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750932AbWBFDjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:39:43 -0500
In-Reply-To: <43E6BF48.5010301@namesys.com>
References: <43E64791.8010302@namesys.com> <43E6521F.5020707@suse.com> <43E6BF48.5010301@namesys.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Mahoney <jeffm@suse.com>,
       LKML <linux-kernel@vger.kernel.org>, kernel-bugzilla@luksan.cjb.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: quality control
Date: Sun, 5 Feb 2006 22:39:23 -0500
To: Hans Reiser <reiser@namesys.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05, 2006, at 22:15, Hans Reiser wrote:
> Jeff Mahoney wrote:
>> Hans Reiser wrote:
>>> http://bugzilla.kernel.org/show_bug.cgi?id=6016
>>>           Summary: reiserfs doesn't build with  
>>> REISERFS_FS_POSIX_ACL=n
>>>    Kernel Version: v2.6.16-rc2-g5b7b644
>>
>> This was a patch from hch, not me. There's already a patch in -mm to
>> fix it.
>
> Please consider adhering to a quality control process.

It's a GIT version of an RC patch for grief's sake!  You don't  
seriously expect people to quadruple-check every trivial patch that  
goes into Linus GIT tree before sending it, do you?  The whole point  
of the RC is to indicate that only smaller patches should be applied  
(and this one was for the most part) so that we can do some kind of  
global-kernel QC.

> Everyone makes mistakes of this kind, the difference is that some  
> persons use a quality control process to avoid burdening more than  
> one other person with them.

Precisely!  The guy who reported the bug is the one person who was  
burdened with it.  It will get fixed in the GIT tree, and only  
somebody who happened to test the dev tree between the two patches  
with that particular .config will have noticed.

BTW: Nice way to CC a private thread to a public list without the  
consent of all parties.  You also made the grievous errors of (A) top- 
posting, (B) fullquoting without snipping irrelevant material, and  
(C) sending flamebait to the list (which I am so stupidly responding  
to).

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


