Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261652AbSJAOra>; Tue, 1 Oct 2002 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261656AbSJAOra>; Tue, 1 Oct 2002 10:47:30 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:30906 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261652AbSJAOr3>; Tue, 1 Oct 2002 10:47:29 -0400
Message-ID: <3D99B672.2090805@oracle.com>
Date: Tue, 01 Oct 2002 16:51:30 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zlatko.calusic@iskon.hr
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain>	<3D99A2F2.70102@oracle.com> <dnelbaclvo.fsf@magla.zg.iskon.hr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic wrote:

>>I'm glad to report that Oracle 9.2 is now able to start once again
>>  on 2.5.x series :)
>>
>>Thanks, cool work as always !
> 
> 
> Was it a known problem for some time?
> 
> I haven't been testing 2.5.x series for some time, and also haven't
> read linux-kernel list last few months, so I don't know exact history
> of the bug. If you can enlighten me, I'm just curious... :)
> 
> I rememeber other more complicated bugs from the older 2.5.x kernels,
> and now I'll test if they're solved in newer ones. I might need some
> help if they still exist (could you lend me a hand if that's the
> case?) as I was getting Oracle internal error - coredump - with only
> one meaningful sentence (at least to me :)). Google was silent on the
> case. :(

I reported the issue on l-k the other day:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.3/1691.html

The more complicated bug you're talking about is the exec_mmap
  change introduced in 2.5.19 and fixed a handful of versions
  later, possibly .28, where PMON wouldn't start after 120"...
  I guess :)


Ciao,

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

