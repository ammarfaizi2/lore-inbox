Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSBZQ4B>; Tue, 26 Feb 2002 11:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSBZQzw>; Tue, 26 Feb 2002 11:55:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:23558 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291272AbSBZQzo>; Tue, 26 Feb 2002 11:55:44 -0500
Message-ID: <3C7BBDE2.8050207@evision-ventures.com>
Date: Tue, 26 Feb 2002 17:54:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com> <3C7BB9A3.30408@evision-ventures.com> <20020226164316.GH4393@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Tue, Feb 26, 2002 at 05:36:51PM +0100, Martin Dalecki wrote:
> 
>>>True, and it could to tricks like listing space used for undelete as "free"
>>>in addition to dynamic garbage collection.
>>>
>>>Though, with a daemon checking the dirs often, or using Daniel's idea of a
>>>socket between unlink() in glibc and an undelete daemon could work quite
>>>similairly.
>>>
>>>Also, there wouldn't be any interaction with filesystem internals, and
>>>userspace would probably work better with non-posix type filesystems (vfat,
>>>hfs, etc) too.
>>>
>>>IOW, there seems to be little gain to having an kernelspace solution.
>>>
>>>
>>IMNSHO everyone thinking about undeletion in Linux should be
>>sentenced to 1 year of VMS usage and asked then again if he
>>still think's that it's a good idea...
>>
> 
> Can you describe the pitfalls that VMS went through so we can aviod the
> problems?
> 
> I haven't had the chance to use VMS, and don't have any hardware to try it
> out on.  Also, just because one implementation was bad (even long ago, and
> unix was considered bad then too... ;) does it mean the entire idea is bad.

Yes I can. The main problem is that most people think that undeletion
is a magical way of getting around stiupid users. But the fact is
that the very same users very quickly adapt to the the presence of
undeletion facilities. And guess whot? They will expect you to
instantly recover allways a version of "this" file from the "stone age".
So the pain for the sysadmin will certainly not be decreased. Quite
contrary for what he expects. For the educated user it was always a pain
in the you know where, to constantly run out of quota space due to
file versioning.


