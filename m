Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316902AbSF0S2U>; Thu, 27 Jun 2002 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSF0S2T>; Thu, 27 Jun 2002 14:28:19 -0400
Received: from ns.escriba.com.br ([200.250.187.130]:60912 "EHLO
	alexnunes.lab.escriba.com.br") by vger.kernel.org with ESMTP
	id <S316902AbSF0S2T>; Thu, 27 Jun 2002 14:28:19 -0400
Message-ID: <3D1B5982.60008@PolesApart.dhs.org>
Date: Thu, 27 Jun 2002 15:29:22 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org> <20020626204721.GK22961@holomorphy.com> <1025125214.1911.40.camel@localhost.localdomain> <1025128477.1144.3.camel@icbm> <20020627005431.GM22961@holomorphy.com> <1025192465.1084.3.camel@icbm> <20020627154712.GO22961@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Wed, 2002-06-26 at 20:54, William Lee Irwin III wrote:
>  
>
>>>Well, my concern here is for the pte_chain_lock() / pte_chain_unlock()
>>>bits. Teaching them about preemption should be all that's needed there.
>>>      
>>>
>
>On Thu, Jun 27, 2002 at 11:40:39AM -0400, Robert Love wrote:
>  
>
>>The newest patch should have the code I shared with you.  So we are OK,
>>no?
>>    
>>
>
>That should cover it, yes. The only questions left are if the user is
>using the right version and where the bug is.
>
>Cheers,
>Bill
>  
>
The user (oops, that is me) was using 
preempt-kernel-rml-2.4.19-pre10-ac2-1, by the time of the report.

Cheers,

Alexandre

