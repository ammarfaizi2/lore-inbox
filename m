Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290848AbSARWAW>; Fri, 18 Jan 2002 17:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290851AbSARWAM>; Fri, 18 Jan 2002 17:00:12 -0500
Received: from freeside.toyota.com ([63.87.74.7]:42760 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S290848AbSARWAE>; Fri, 18 Jan 2002 17:00:04 -0500
Message-ID: <3C489AD9.8010307@lexus.com>
Date: Fri, 18 Jan 2002 13:59:53 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020116
X-Accept-Language: en-us
MIME-Version: 1.0
To: lathi@seapine.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Normal unix behaviour -

It's always been that way....

jjs

Doug Alcorn wrote:

>I had a weird situation with my application where the user deleted all
>the database files while the app was still reading and writing to the
>opened file descriptor.  What was weird to me was that the app didn't
>complain.  It just went merrily about it's business as if nothing were
>wrong.  Of course, after the app shut down all it's data was lost.
>
>Since I didn't expect this behavior I wrote a simple little program to
>test it[1].  Sure enough, you can rm a file that has opened file
>descriptors and no errors are generated.  Interestingly, sun solaris
>does the same thing.  Since this is the case, I thought this might be
>a feature instead of a bug (ms-win doesn't allow the rm).  So, my
>question is where is this behavior defined?  Is it a kernel issue?
>Does POSIX define this behavior?  Is it a libc issue?  
>
>I tried to google this, but couldn't think of the right terms to
>describe it.  As I'm not on lkm, I would appreciate a CC: to
><doug@lathi.net>.
>


