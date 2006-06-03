Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWFCIxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWFCIxD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 04:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWFCIxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 04:53:03 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:6023 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932095AbWFCIxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 04:53:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1Ha6No2Y0Fmmi+1sPR+ONCwrfUnf50TOn5trzjOn/QcPjVz4Mkxk0h8QiZ1wZ/6AAaJ8jdLVi5/T++gMheJ3yrkeCyyFN0HNdTdbixSOoLh0fQ4oL7btOURK6FBCw+pLUmBG6zPVMM/tHrs1kNIveZvHegwbCoiq6Q60HVQIW0I=  ;
Message-ID: <44814DE4.9020200@yahoo.com.au>
Date: Sat, 03 Jun 2006 18:52:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Andrew Morton'" <akpm@osdl.org>, "'Chris Mason'" <mason@suse.com>,
       "'Con Kolivas'" <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix smt nice lock contention and optimization
References: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
In-Reply-To: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> OK, final rolled up patch with everyone's changes. I fixed one bug
> introduced by Con's earlier patch that there is an unpaired
> spin_trylock/spin_unlock in the for loop of dependent_sleeper().
> Chris, Con, Nick - please review and provide your signed-off-by line.
> Andrew - please consider for -mm inclusion.  Thanks.

Thanks Ken, you can add a Signed-off-by: Nick Piggin <npiggin@suse.de>
for my part.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
