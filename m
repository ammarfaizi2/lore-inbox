Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUIFXer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUIFXer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUIFXer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:34:47 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:53454 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267363AbUIFXeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:34:44 -0400
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org>
Message-ID: <cone.1094513660.210107.6110.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: raybry@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@redhat.com, piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Date: Tue, 07 Sep 2004 09:34:20 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>> > A scan of the change logs for swappiness related changes shows nothing that 
>>  > might explain these changes.  My question is:  "Is this change in behavior
>>  > deliberate, or just a side effect of other changes that were made in the vm?" 
>>  > and "What kind of swappiness behavior might I expect to find in future kernels?".
>> 
>>  The change was not deliberate but there have been some other people report 
>>  significant changes in the swappiness behaviour as well (see archives). It 
>>  has usually been of the increased swapping variety lately. It has been 
>>  annoying enough to the bleeding edge desktop users for a swag of out-of-tree 
>>  hacks to start appearing (like mine).
> 
> All of which is largely wasted effort.  It would be much more useful to get
> down and identify which patch actually caused the behavioural change.

I don't disagree. Is there anyone who has the time and is willing to do the 
regression testing? This is a general appeal to the mailing list.

Cheers,
Con

