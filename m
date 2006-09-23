Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWIWIF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWIWIF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWIWIF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:05:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:36062 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751080AbWIWIFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:05:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Y9AqEOtnOkRfT/g8ZcBSynTqcAflQDvD3oia1VZTot+s/r0+4n0PTcC21r9p0HNvDGwZ9ZYU2nkCmt7mdmjv8b6rPWR7eDUnLpk78Nsm9Mz8uodRjlYo86GPPADIcGTI1nr+K1LFB1MjqDKsDCwYzD6fyN76tZ6G9ppECxJ5YQs=
Message-ID: <4514EABC.2030300@gmail.com>
Date: Sat, 23 Sep 2006 12:05:16 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Schwartz <davids@webmaster.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The GPL: No shelter for the Linux kernel?
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com> <Pine.LNX.4.64.0609221440470.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609221440470.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [ Sorry if this shows up twice - the first post to linux-kernel was 
>   apparently eaten by an over-eager spam filter with an agenda ;^]
> 
> On Fri, 22 Sep 2006, David Schwartz wrote:
>> This is probably going to be controversial, but Linus should seriously
>> consider adding a clause that those who contribute to the kernel from now on
>> consent to allow him to modify the license on their current contributions
>> and all past contributions, amending the Linux kernel license as
>> appropriate. This would at least begin to reduce this problem over the next
>> few years, leaving fewer and fewer people with claim to less and less code
>> who would have legal standing to object.
> 
> It's the last thing I'd ever want to do, for all the same reasons the 
> kernel doesn't have the "or later versions" language wrt licenses.
> 
> I don't actually want people to need to trust anybody - and that very much 
> includes me - implicitly.
> 
> I think people can generally trust me, but they can trust me exactly 
> because they know they don't _have_ to.
> 
> The reason the poll and the whitepaper got started was that I've obviously 
> not been all that happy with the GPLv3, and while I was pretty sure I was 
> not alone in that opinion, I also realize that _everybody_ thinks that 
> they are right, and that they are supported by all other right-thinking 
> people. That's just how people work. We all think we're better than 
> average.
> 
> So while I personally thought it was pretty clear that the GPLv2 was the 
> better license for the kernel, I didn't want to just depend on my own 
> personal opinion, but I wanted to feel that I had actually made my best to 
> ask people.


Regarding the GPLv2 vs v3 debate, i don't think anyone is in favour of a
different view, but ..


> Now, I could have done it all directly on the Linux-kernel mailing list, 
> but let's face it, that would just have caused a long discussion and we'd 
> not have really been any better off anyway. So instead, I did
> 
> 	git log | grep -i signed-off-by: |
> 		cut -d: -f2- | sort | uniq -c | sort -nr | less -S


When applied to subsystems, the patch author "A" applies his/her patch
to the repo, the MAINTAINER cherry picks the patches for submitting to
the kernel.

In such a case, it becomes,

Signed-off-by: A
Signed-off-by: MAINTAINER

in a subsystem there are indeed many contributors, eventually it is indeed

Signed-off-by: "x"
Signed-off-by: MAINTAINER


So it is indeed incorrect to term that the MAINTAINER is the most
popular Contributor, because the CONTRIBUTOR is the PATCH AUTHOR
himself, not the MAINTAINER.


Manu
