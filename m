Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbUKJUbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUKJUbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUKJUbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:31:19 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:52611 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262011AbUKJU2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:28:52 -0500
Message-ID: <41927ABA.9090604@tmr.com>
Date: Wed, 10 Nov 2004 15:31:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Clayton Weaver <cgweav@email.com>, linux-kernel@vger.kernel.org
Subject: Re: broken gcc 3.x update ("3.4.3""fixed")
References: <20041110094011.0A3434BE64@ws1-1.us4.outblaze.com><20041110094011.0A3434BE64@ws1-1.us4.outblaze.com> <20041110100723.GE24336@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041110100723.GE24336@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Wed, Nov 10, 2004 at 04:40:10AM -0500, Clayton Weaver wrote:
> 
>>Apropos of the recent "older compilers" discussion,
>>the string literal concatenation pre-processor bug
>>that I mentioned encountering in gcc-3.3.x and
>>gcc-3.4.[0,1] appears to be fixed in gcc-3.4.3.
>>(It was not the well-known "##" token pasting
>>pre-processor bug, incidentally.)
>>
>>I've only tested with glibc-2.2.5 so far,
>>but I could reproduce it before with both
>>glibc-2.2.5 and glibc-2.3.2, so it probably
>>really is fixed.
> 
> 
> 1) What the hell does glibc version have to preprocessor behaviour?

There is no claim that it has anything, it just looks like a nice 
complete statement of the conditions of the test. I believe there were 
some issues with another problem, but I don't remember details.

> 2) Could you post the code (as small as possible) that triggers whatever
> bug you are talking about?  Not a "here's the fragment that gets miscompiled"
> but something that could be fed to gcc and actually reproduce the bug.

I'd like to see that as well, in case it's something I might have in 
application code.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
