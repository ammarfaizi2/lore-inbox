Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSJYFa0>; Fri, 25 Oct 2002 01:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSJYFaZ>; Fri, 25 Oct 2002 01:30:25 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:15786 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261287AbSJYFaZ>;
	Fri, 25 Oct 2002 01:30:25 -0400
Message-ID: <3DB8D86E.1000008@colorfullife.com>
Date: Fri, 25 Oct 2002 07:36:46 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Hugh Dickins <hugh@veritas.com>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]updated ipc lock patch
References: <3DB87458.F5C7DABA@digeo.com> <Pine.LNX.4.44.0210242342460.1169-100000@localhost.localdomain> <3DB88298.735FD044@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hugh Dickins wrote:
>  
>
>>...
>>Manfred and I have both reviewed the patch (or the 2.5.44 version)
>>and we both recommend it highly (well, let Manfred speak for himself).
>>
>>    
>>
>
>OK, thanks.
>
>So I took a look.  Wish I hadn't :(  The locking rules in there
>are outrageously uncommented.  You must be brave people.
>  
>
Ahm. No idea who wrote the current locking. But the patch is very nice, 
it reduces the lock contention without increasing the number of spinlock 
calls.

--
    Manfred

