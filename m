Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283572AbRK3JSZ>; Fri, 30 Nov 2001 04:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283576AbRK3JSP>; Fri, 30 Nov 2001 04:18:15 -0500
Received: from [203.25.188.10] ([203.25.188.10]:49028 "EHLO
	whitsun.whitsunday.net.au") by vger.kernel.org with ESMTP
	id <S283572AbRK3JSH> convert rfc822-to-8bit; Fri, 30 Nov 2001 04:18:07 -0500
From: John Fort <johnf@whitsunday.net.au>
To: linux-kernel@vger.kernel.org
Cc: johnf@whitsunday.net.au
Subject: [OT] Style winge.  patch-2.4.16
Date: Fri, 30 Nov 2001 19:16:54 +1000
Message-ID: <hgje0uknoadn1dsrtscnnrh3383e3gpu2n@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In patch-2.4.16:kernel/sysctl.c 
is this turdlet lurking in wait for a 3am kernel hacker.

	{VM_MAX_READAHEAD, "max-readahead",
	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},

While "VM_MAX_READAHEAD" will always be a separate object to
"vm_max_readahead", it will not pass what Kernighan and Plaugher
describe as the 'telephone test'.

"grep -i VM_MIN_READAHEAD" for the same threat to sanity.


cu  johnf

