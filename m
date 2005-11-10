Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVKJOMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVKJOMA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVKJOMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:12:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:62148 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750956AbVKJOL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:11:59 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 21/21] i386 Ldt context inline
Date: Thu, 10 Nov 2005 15:11:41 +0100
User-Agent: KMail/1.8
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200511080442.jA84g2vH009964@zach-dev.vmware.com>
In-Reply-To: <200511080442.jA84g2vH009964@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101511.41706.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 05:42, Zachary Amsden wrote:
> I was also able to get the LDT switching functionality out of the
> critical path in switch_mm, which reduces the number of function calls,
> potential TLB misses and code size.

Hmm - i don't think your description matches the patch. Or where is
the critical path here?

-Andi
