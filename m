Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVINUeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVINUeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVINUeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:34:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13784 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964806AbVINUeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:34:14 -0400
Message-ID: <432887C8.2000607@redhat.com>
Date: Wed, 14 Sep 2005 16:27:52 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Assar <assar@permabit.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>	<784q8qrsad.fsf@sober-counsel.permabit.com>	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>	<788xy2qas0.fsf@sober-counsel.permabit.com>	<20050913183948.GE14889@dmt.cnet>	<784q8okdfn.fsf@sober-counsel.permabit.com>	<20050913193539.GB17222@dmt.cnet>	<784q8oivp4.fsf@sober-counsel.permabit.com>	<43287221.8020602@redhat.com>	<7864t3h1xw.fsf@sober-counsel.permabit.com>	<432884CE.9060506@redhat.com> <78r7brflb0.fsf@sober-counsel.permabit.com>
In-Reply-To: <78r7brflb0.fsf@sober-counsel.permabit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assar wrote:

>Peter Staubach <staubach@redhat.com> writes:
>  
>
>>One other thing -- it doesn't seem particularly correct to me to just
>>silently truncate the symbolic link contents.
>>    
>>
>
>Sure, and 2.6 indeed returns ENAMETOOLONG.  I was just trying to close
>the problem and not change the functionality in 2.4.  If the consensus
>is that we should change it to return an error, I can certainly cook
>up patches for that.
>

Understand.  I would recommend that the 2.4 kernel be modified to return
an error, since we are already modifying the area anyway.

    Thanx...

       ps
