Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136740AbREAWaq>; Tue, 1 May 2001 18:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136743AbREAWag>; Tue, 1 May 2001 18:30:36 -0400
Received: from james.kalifornia.com ([208.179.59.2]:56421 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136740AbREAWad>; Tue, 1 May 2001 18:30:33 -0400
Message-ID: <3AEF34AE.3070601@blue-labs.org>
Date: Tue, 01 May 2001 15:11:58 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.8.1+) Gecko/20010430
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: * Re: Severe trashing in 2.4.4
In-Reply-To: <20010501235046.A23616@unternet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't say for a definite fact that it was reiserfs but I can say for a 
definite fact that something fishy happens sometimes.

If I have a text file open, something.html comes to mind, If I edit it 
and save it in one rxvt and open it in another rxvt, my changes may not 
be there.  If I save it *again* or exit the editing process, I will see 
the changes in the second term.  No, I'm not accidently forgetting to 
save it, I know for a fact that I saved it and the first terminal shows 
the non-modified state with the changes and the second term shows the 
previous data.

Somewhere something is stuck in cache and what's on disk isn't what's in 
cache and a second process for some reason gets what is on disk and not 
what is in cache.

It happens infrequently but it -does- happen.

David

Frank de Lange wrote:

>Well,
>
>When a puzzled Alexey wondered whether the problems I was seeing with 2.4.4
>might be related to a failure to execute 'make clean' before compiling the
>kernel, I replied in the negative as I *always* clean up before compiling
>anything. Yet, for the sake of science and such I moved the kernel tree and
>started from scratch.
>
>The problems I was seeing are no more, 2.4.4 behaves like a good kernel should.
>
>Was it me? Was it reiserfs? Was is divine intervention? I will probably never
>find out, but for now this thread, and the accompanying scare, can Resquiam In
>Paces.
>
>Cheers//Frank
>


