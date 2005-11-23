Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVKWQur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVKWQur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVKWQur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:50:47 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:28830 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S932092AbVKWQuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:50:46 -0500
Message-ID: <43849D79.5040507@mnsu.edu>
Date: Wed, 23 Nov 2005 10:48:57 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Zan Lynx <zlynx@acm.org>, ak@muc.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs-masters@oss.sgi.com, nathans@sgi.com
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <43829ED2.3050003@mnsu.edu> <20051122150002.26adf913.akpm@osdl.org> <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org> <20051122170507.37ebbc0c.akpm@osdl.org> <Pine.LNX.4.64.0511221735400.13959@g5.osdl.org> <4383E4F6.8000202@mnsu.edu> <Pine.LNX.4.64.0511221944120.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511221944120.13959@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>>BTW: Since I have your ear, this same version DOES seem to have some
>>other bug as well.  I did a "make distclean" and the "rm -f" of all he
>>object files hung forever in "D" state.  I'm using XFS on IDE disks. 
>>I'm using the same config as was posted before.  I didn't get anything
>>in an log files that would indicate a problem.  Has this been reported? 
>>If not, what can I do to make a meaningful report?
>>    
>>
>
>I don't recognize those symptoms, so more info would be nice.
>
>For example, it would be good to know where the threads are that are 
>waiting uninterruptibly. You should be able to get that info with Sysrq 
>'T' (or with the old "ctrl + ScrollLock" thing).
>
>That should tell us if they're hung on a semaphore or waiting for disk IO 
>to complete or what...
>
It has been pointed out to me that the XFS team does know about this and 
is looking into it.  The thread is "unable to use dpkg 2.6.15-rc2".

-- 
Jeffrey Hundstad

