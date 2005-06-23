Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbVFWIT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbVFWIT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVFWIPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:15:33 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:21640 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262527AbVFWHFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:05:49 -0400
Message-ID: <42BA5F37.6070405@yahoo.com.au>
Date: Thu, 23 Jun 2005 17:05:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
CC: Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: [patch][rfc] 0/5: remove PageReserved
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The following set of patches removes PageReserved from core kernel
code, and clears the way for the page flag to be completely removed
when it is removed from all arch/ code. Drivers are mostly fairly
trivial, but will need auditing.

Arch maintainers and driver writers will need to help get that done.

Actually, only patches 4 and 5 are really required - the first 3 are
very minor things I noticed along the way (but I'm putting them in
this series because they have clashes).

Not quite ready for merging yet, although probably after the next
round of comments it will be. It boots and runs on i386, ppc64, ia64
and not tested elsewhere.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
