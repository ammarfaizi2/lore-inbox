Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRBRCUL>; Sat, 17 Feb 2001 21:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132594AbRBRCUB>; Sat, 17 Feb 2001 21:20:01 -0500
Received: from [208.179.59.198] ([208.179.59.198]:49973 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S132577AbRBRCTt>; Sat, 17 Feb 2001 21:19:49 -0500
Message-ID: <3A8F3106.6020107@kalifornia.com>
Date: Sat, 17 Feb 2001 18:18:46 -0800
From: David <david@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac17 i686; en-US; 0.8) Gecko/20010216
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        reiser@namesys.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
In-Reply-To: <1217040000.982455419@tiny> <3A8F29C5.7000302@kalifornia.com> <20010218030727.C13823@unternet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I run glibc-2.2.1 as well, so that might be one of the factors
> contributing to this. Then again, glibc-2.2.1 with ext2 does not cause any
> problems whatsoever with mozilla. So it could be that reiserfs + glibc-2.2.1 is
> a bad combination, question remains which of these two is the culprit (if not
> both). Since glibc-2.2.2 is out, I will give that a try as well. Not tonight
> though...
> 
> And no, I'm not running RedHat 7.x for those who might think so (and
> automatically blame everything on it).
> 
> When did you switch to glibc-2.2.1? Were you running reiserfs before that?
> 
> Cheers//Frank


Yes I was running reiserfs before 2.2.1 and I switched to 2.2.1 a couple 
months ago.  Since then I've been dealing with issues.  I've had to 
recompile half a dozen things similar to sendmail, apache etc.  They 
segfaulted.  It wasn't as purely backward compatible as expected.

I typically compile everything on one machine and distribute it.  Thus 
far everything has been ok save a few issues I haven't been able to pin 
down.  One of these issues is the inability to compile mozilla.  Also 
related, I can't recompile gcc 2.95.2.

All of these things I was able to do just fine before the changeover.  
To note, I used to cvs up mozilla and recompile it every few days.  I 
suppose I'll build an ext2 system and try things out.

Oh btw, I don't run That distribution either.

-d

