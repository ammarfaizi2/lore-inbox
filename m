Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbTBAPzJ>; Sat, 1 Feb 2003 10:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbTBAPzJ>; Sat, 1 Feb 2003 10:55:09 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:20437 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264885AbTBAPzI>; Sat, 1 Feb 2003 10:55:08 -0500
Message-ID: <3E3BEFDB.3060208@blue-labs.org>
Date: Sat, 01 Feb 2003 08:03:39 -0800
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030125
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@digeo.com>
Subject: Re: NFS problems, 2.5.5x
References: <3E3B2D2E.8000604@blue-labs.org> <15931.35891.22926.408963@charged.uio.no>
In-Reply-To: <15931.35891.22926.408963@charged.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last time NFS was working, I had 2.4.19 and 2.5.53 clients on a 
2.5.59 server, that was yesterday.  I had experienced a slight problem 
with it last week when my 2.5.53 client was booted for first time on 
2.5.5x, it was previously a 2.4 kernel.  The server OOPSed repeatedly 
shortly after bootup in NFS stuff then it never happened again and was 
rock solid until today.

David

Trond Myklebust wrote:

>>>>>>" " == David Ford <david+powerix@blue-labs.org> writes:
>>>>>>            
>>>>>>
>
>     > Synopsis: nfsserver:/home/david mount, get dir. entries loops
>     > forever,
>     > 2.5.59 for client and server.
>
>     > Example: ls -l /home/david
>
>     > An strace will show the same directory entries flying by over
>     > and over until memory is exhausted or ^c comes along.  It
>     > worked at first for about 30 minutes while I finished the new
>     > gentoo install on my desktop, but then things got weird.  the
>     > nfs server spat out a big long callback trace (oops) and died
>     > hard.  Had to reset the power.  The looping started just
>     > minutes before that.  I've rebooted, tried 2.5.53 on the client
>     > but no go.
>
>AFAICR, there have been no changes to the NFS client readdir code since
>2.5.30.
>
>Cheers,
>  Trond
>  
>

