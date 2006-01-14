Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWANGFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWANGFh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWANGFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:05:37 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:28273 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbWANGFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:05:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Z8wL0fP/54+6vVtfxlbGCC+ufYR78FwkvW7SxMIt/oFm9EEVh31ZdcDXFAy4m7L+7s6QfMRqn+h50xp61w6Ea+8rPBB6cPMR+uxuReGb05dhkh55TUhIbRa5Jt7md5zTJoxE10C07/jJVsongL3fLOzhes3KMGJK6sh267iLAK4=  ;
Message-ID: <43C894AD.1060202@yahoo.com.au>
Date: Sat, 14 Jan 2006 17:05:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, Martin Bligh <mbligh@google.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C84496.6060506@bigpond.net.au> <43C8861E.5070203@yahoo.com.au> <200601141640.45582.kernel@kolivas.org>
In-Reply-To: <200601141640.45582.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Saturday 14 January 2006 16:03, Nick Piggin wrote:
> 
>>Ideally, balancing should be completely unaffected when all tasks are
>>of priority 0 which is what I thought yours did, and why I think the
>>current system is not great.
> 
> 
> The current smp nice in mainline 2.6.15 is performance neutral when all are 
> the same priority. It's only this improved version in -mm that is not.
> 

Oh sure. I wasn't talking about performance though.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
