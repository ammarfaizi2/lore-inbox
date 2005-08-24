Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbVHXUDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbVHXUDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbVHXUDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:03:46 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:50814 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751524AbVHXUDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:03:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hWUcU/tbqstks+hUcbqT5WremD7M1UrvxaiSlTBEZ1Tzr+I89EXf4B4c52fxY4eHpiuU0gAq8DiOVn2NlA1fPspiPZ98ym1vNy+gQLGQFvl6q3l9H3DCl+e6gLu3hsRMiosRDSvq8Vmni4u2G9NBitJas6iZxzYlk/N7Ug5Ws50=  ;
Message-ID: <430C617E.8080002@yahoo.com.au>
Date: Wed, 24 Aug 2005 22:01:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: dino@in.ibm.com, paulus@samba.org, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix
References: <20050824111510.11478.49764.sendpatchset@jackhammer.engr.sgi.com>	<20050824112640.GB5197@in.ibm.com> <20050824044648.66f7e25a.pj@sgi.com>
In-Reply-To: <20050824044648.66f7e25a.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Dinakar wrote:
> 
>>Can we hold on to this patch for a while, as I reported yesterday,
> 
> 
> Sure - though I guess it's Linus or Andrew who will have to do
> the holding.
> 
> I sent it off contingent on the approval of yourself, Hawkes and Nick.
> 

I get the feeling that the problem would be present in more
than just misaligned nodes.

On the POWER5 for example, Dinakar probably has SMT enabled,
which may cause something similar to pop up.

I get the feeling that exclusive cpusets should just be
completely disabled for 2.6.13, and John & Ingo's complete
fix put in 2.6.14-early

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
