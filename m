Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030626AbWBIOLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbWBIOLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWBIOLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:11:08 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:61579 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030626AbWBIOLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:11:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lPMwNDLxDUDVUdCsrverOLz6qEl7GvNg3/Ko1KRNZjuY7cL/kntbwU5TAghdCxLZHXt32+sHFoM6hksNT0nVF0hGS0lggXo2USTznKpWNOategbSDw9zjXDMJWeHVpC84NsOhYKFS9+/gfHfrzyRjfTEpYYsMKixzAzTP34K+S0=  ;
Message-ID: <43EB4D7C.4060309@yahoo.com.au>
Date: Fri, 10 Feb 2006 01:11:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: MIke Galbraith <efault@gmx.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
References: <1139473463.8028.13.camel@homer>	<43EAFF6D.1040604@yahoo.com.au>	 <20060209004712.3998e336.akpm@osdl.org>	<1139478652.7867.9.camel@homer>	 <20060209021136.410f1128.akpm@osdl.org>  <43EB393F.1070409@yahoo.com.au> <1139493187.7618.4.camel@homer>
In-Reply-To: <1139493187.7618.4.camel@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIke Galbraith wrote:
> On Thu, 2006-02-09 at 23:44 +1100, Nick Piggin wrote:
> 
>>Andrew Morton wrote:
> 
> 
>>>>(or Nick, do you have the supposed fix handy?)
>>>
>>>
>>>Yeah, I'm still scratching my head over the mystery fix.
>>>
>>>
>>
>>The mm/swap.c hunk from git 8519fb30e438f8088b71a94a7d5a660a814d3872
>>is the mystery fix (the mm.h hunk is already in there).
>>
>>I suppose you'd better verify that -mm works fine with the patch as
>>well, when you get time.
> 
> 
> Verified.  rc2-mm1 worked fine, and plugging the extracted bit below
> into rc1-mm5 fixed it's BUG.
> 

Thanks. And thanks for reporting.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
