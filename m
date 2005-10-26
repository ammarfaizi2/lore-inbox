Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVJZIXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVJZIXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVJZIXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:23:18 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:21884 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932590AbVJZIXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:23:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=XRd4UnVtHnTaJKFYHSYryIOZazbByuMesCO8eFG2jMCGgBmt5kWIgPkazl4ubo8f0a8sC1uJ7+Ec0mjhjbe5Ql9gyG6SfhiV3vf6JAQUYqZWVW43a0Z4E29f5voXmZZvNy/DprYzbEPcMn/Pj/bte2zmClivFAajZfLAOBHRWVA=  ;
Message-ID: <435F3D3A.8080304@yahoo.com.au>
Date: Wed, 26 Oct 2005 18:24:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc5-np1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/2.6.14-rc5-np1/

2.6.14-rc5-np1 includes Hugh's pagefault scalability work and my
lockless pagecache and RCU radix tree work (which is getting stable).

Also, some straight-line performance increases for mm/ which are
worth about 5% kernel residency on kbuild on UP, and about 7.5% on
SMP on a P4 Xeon.

And some various small improvements to corner cases in the radix tree
code.

Performance testing and results would be interesting, on big machines
or small.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
