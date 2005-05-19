Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVESNoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVESNoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 09:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVESNoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 09:44:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45766 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262497AbVESNoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 09:44:01 -0400
Message-ID: <428C9792.5040007@redhat.com>
Date: Thu, 19 May 2005 09:41:38 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Lee Revell <rlrevell@joe-job.com>, steve <lingxiang@huawei.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
Subject: Re: why nfs server delay 10ms in nfsd_write()?
References: <0IGP00IZRULADZ@szxml02-in.huawei.com>	 <1116472423.11327.1.camel@mindpipe>  <428C8C32.2030803@redhat.com> <1116509166.10911.41.camel@lade.trondhjem.org>
In-Reply-To: <1116509166.10911.41.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>to den 19.05.2005 Klokka 08:53 (-0400) skreiv Peter Staubach:
>  
>
>>There are certainly many others way to get gathering, without adding an
>>artificial delay.  There are already delay slots built into the code 
>>which could
>>be used to trigger the gathering, so with a little bit different 
>>architecture, the
>>performance increases could be achieved.
>>
>>Some implementations actually do write gathering with NFSv3, even.  Is
>>this interesting enough to play with?  I suspect that just doing the 
>>work for
>>NFSv2 is not...
>>    
>>
>
>Write gathering does still apply to stable NFSv3/v4 writes, so an
>optimisation may yet benefit applications that use O_DIRECT writes, or
>that require the use of the "noac" or "sync" mount options.
>
>I'm not aware of any ongoing projects to work on this, though, so it
>would probably be up to those parties that see it as beneficial to step
>up to the plate.
>

Cool.  If anyone is interested, I would be interested in participating 
in a design
discussion and perhaps even prototyping.

    Thanx...

       ps
