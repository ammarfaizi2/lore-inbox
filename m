Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWJLRmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWJLRmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWJLRmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:42:20 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:11615 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751260AbWJLRmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=B5XlsVU+IzXeuRSg6ywf3UeepibrQnY2ONNk9Tr+7/WE1e9lE/pYFcv4SoYd6coai2/iIBS5bivzjsJkhT0MR6LQgtZAA6CPc8hZue/LkMkGvh17bExM3A8a/t4Ql0IVq0iaGdBFi5wvNCgyof8oonQl3qcY9CUaipe4KNG7uJ4=  ;
Message-ID: <452E7E73.5090109@yahoo.com.au>
Date: Fri, 13 Oct 2006 03:42:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Harris <googlegroups@mgharris.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
References: <20061011160740.GA6868@dingu.igconcepts.com> <452DF9D2.6020306@yahoo.com.au> <20061012141903.GA6593@dingu.igconcepts.com>
In-Reply-To: <20061012141903.GA6593@dingu.igconcepts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Harris wrote:
>>Michael Harris wrote:

>>These unused swap offset entry messages seem to indicate extensive memory
>>corruption in your page tables. Probably bad RAM, or system overheating
>>when you load it up :(
>>
>>Can you run a good memory tester like memtest86+ overnight?
> 
> 
> 
> Hi, I think this is the case, a stick of ram gone bad. It had worked 
> testing under 2.4 but coincidentally failed about the time I upgraded
> to 2.6. memtest86 uncovered it at once. Sorry for the trouble and thanks
> for the help.

No problem, thanks for reporting.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
