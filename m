Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTBAVkH>; Sat, 1 Feb 2003 16:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTBAVkH>; Sat, 1 Feb 2003 16:40:07 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:57496 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264992AbTBAVkG>; Sat, 1 Feb 2003 16:40:06 -0500
Message-ID: <3E3C40E9.1010901@blue-labs.org>
Date: Sat, 01 Feb 2003 16:49:29 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030131
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@digeo.com>
Subject: Re: NFS problems, 2.5.5x
References: <3E3B2D2E.8000604@blue-labs.org>	<15931.35891.22926.408963@charged.uio.no>	<3E3BEFDB.3060208@blue-labs.org> <15931.62606.441404.74917@charged.uio.no>
In-Reply-To: <15931.62606.441404.74917@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.  Today I haven't experienced the loop problem.  On the other hand,
when I reboot back and forth between 2.5.53 and 2.5.59, I have to
restart the server nfs programs or I get permission denied on the client
and "rpc.mountd: getfh failed: Operation not permitted" on the server.

I have also had to restart 2.4 clients because NFS silently hangs.  I
believe there's a few patches on the list that I need to apply regarding
this.

David

Trond Myklebust wrote:

>>>>>>" " == David Ford <david+powerix@blue-labs.org> writes:
>>>>>>            
>>>>>>
>
>     > The last time NFS was working, I had 2.4.19 and 2.5.53 clients
>     > on a
>     > 2.5.59 server, that was yesterday.  I had experienced a slight
>     >        problem
>     > with it last week when my 2.5.53 client was booted for first
>     > time on 2.5.5x, it was previously a 2.4 kernel.  The server
>     > OOPSed repeatedly shortly after bootup in NFS stuff then it
>     > never happened again and was rock solid until today.
>
>So have you tried out the 2.5.53 client since you noticed this
>problem?
>
>Cheers,
>  Trond
>  
>

-- 
I may have the information you need and I may choose only HTML.  It's up 
to you. Disclaimer: I am not responsible for any email that you send me 
nor am I bound to any obligation to deal with any received email in any 
given fashion.  If you send me spam or a virus, I may in whole or part 
send you 50,000 return copies of it. I may also publically announce any 
and all emails and post them to message boards, news sites, and even 
parody sites.  I may also mark them up, cut and paste, print, and staple 
them to telephone poles for the enjoyment of people without internet 
access.  This is not a confidential medium and your assumption that your 
email can or will be handled confidentially is akin to baring your 
backside, burying your head in the ground, and thinking nobody can see 
you butt nekkid and in plain view for miles away.  Don't be a cluebert, 
buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE



