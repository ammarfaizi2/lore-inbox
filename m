Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWBNDoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWBNDoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWBNDoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:44:21 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:15699 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030304AbWBNDoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:44:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jWYfpYmvO7q7mIyHd7hDJIYiT5EAq0nns8wBnsRnPnWQTzW6Q2bY2+Uj1ON3h/5SO8Lzb6FRo1OQpWc/TyyNdq4fcf4Phr3UpOtW6LioJWBRkS/qlvB2RLdZgqh3fUKTdM9Zbvscx0nUq5uApXzZ3WxzI1N6Azh+QKxIGBf1zRg=  ;
Message-ID: <43F15211.2090206@yahoo.com.au>
Date: Tue, 14 Feb 2006 14:44:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/2] fix perf. bug in wake-up load balancing for aim7
 and db workload
References: <200602140309.k1E394g17590@unix-os.sc.intel.com> <20060213193856.696bf1f0.akpm@osdl.org>
In-Reply-To: <20060213193856.696bf1f0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> 
> Well I don't see any benchmark numbers in the original patch.  Just an
> assertion that it "should" help something.
> 

The regression was in a Ken's commercial database benchmark. I couldn't
reproduce it but presumably it did fix it otherwise Ken would would have
piped up?

> I'm more inclined to revert it and not add the sysctl (ugh) until we have a
> good reason to do so.
> 

If you revert this then Ken's database benchmark gets worse. Hence the
sysctl.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
