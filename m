Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWBNEAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWBNEAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWBNEAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:00:15 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:38305 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750946AbWBNEAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:00:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uu2KMSRjfmr0UB1Dk5+YtzOfefIFkY+rMz8nWrIyd/J9w3EUx9J903zvwfv2IuwP2tXexFnCgFu5vrZJEc9SqktGHA/BJ+roSLIRttLbjpiU5/Lu1mvMirAxL7hLO3k6hrIpKyRiSSaQB0NRnszm+gw5GGvTEHByL2sKUt4yMAo=  ;
Message-ID: <43F15531.3060809@yahoo.com.au>
Date: Tue, 14 Feb 2006 14:57:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] fix perf. bug in wake-up load balancing for aim7
 and db workload
References: <200602140309.k1E394g17590@unix-os.sc.intel.com> <20060213193856.696bf1f0.akpm@osdl.org> <43F15211.2090206@yahoo.com.au>
In-Reply-To: <43F15211.2090206@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Andrew Morton wrote:
> 
>>
>>
>> Well I don't see any benchmark numbers in the original patch.  Just an
>> assertion that it "should" help something.
>>
> 
> The regression was in a Ken's commercial database benchmark. I couldn't
> reproduce it but presumably it did fix it otherwise Ken would would have
> piped up?
> 

BTW, I did actually ask that you hold off merging it until Ken came
back with some numbers.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
