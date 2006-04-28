Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWD1FIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWD1FIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWD1FIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:08:12 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:60521 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965068AbWD1FIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:08:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5nuoWS2zCsmx70N2n2Kwwtx2y+74ELaKPvLOOAmvCS3I9KabKPsxsEdUJQqEjtK3+bSfwMAb7Dhp8FEnizb2AedWQq9XjDQ1o2DczGOp+ikNJxYjlq4ZF4XS3l0ofh5o0OqQ+yYUvOqpX4pVCHRMef6c3xZl9TUEX0WeawCRK40=  ;
Message-ID: <4451A290.5040508@yahoo.com.au>
Date: Fri, 28 Apr 2006 15:05:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Dave Peterson <dsp@llnl.gov>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, riel@surriel.com, akpm@osdl.org
Subject: Re: [PATCH 1/2] mm: serialize OOM kill operations
References: <200604251701.31899.dsp@llnl.gov> <200604261014.15008.dsp@llnl.gov> <44503BA2.7000405@yahoo.com.au> <200604270956.15658.dsp@llnl.gov> <4451A163.5020304@yahoo.com.au>
In-Reply-To: <4451A163.5020304@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> mm_struct already has what you want -- dumpable:2 -- if you just put
> your bit in an adjacent bitfield, you'll be right.

I should have read all my email first. Ignore me ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
