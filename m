Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265953AbUEUUda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUEUUda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUEUUd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:33:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:38066 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265953AbUEUUdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:33:00 -0400
Date: Fri, 21 May 2004 13:32:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, brettspamacct@fastclick.com
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <93090000.1085171530@flay>
In-Reply-To: <m3lljld1v1.fsf@averell.firstfloor.org>
References: <1Y6yr-eM-11@gated-at.bofh.it> <1YbRm-4iF-11@gated-at.bofh.it><1Yma3-4cF-3@gated-at.bofh.it> <1YmjP-4jX-37@gated-at.bofh.it><1YmMN-4Kh-17@gated-at.bofh.it> <1Yn67-50q-7@gated-at.bofh.it> <m3lljld1v1.fsf@averell.firstfloor.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Martin J. Bligh" <mbligh@aracnet.com> writes:
> 
>> For any given situation, you can come up with a scheduler mod that improves
>> things. The problem is making something generic that works well in most
>> cases. 
> 
> The point behind numa api/numactl is that if the defaults
> don't work well enough you can tune it by hand to be better.
> 
> There are some setups which can be significantly improved with some
> hand tuning, although in many cases the default behaviour is good enough
> too.

Oh, I'm not denying it can make things better ... just 90% of the people
who want to try it would be better off leaving it the hell alone ;-)

M.

