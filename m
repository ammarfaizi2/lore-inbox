Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUEUXCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUEUXCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUEUWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:41:35 -0400
Received: from zero.aec.at ([193.170.194.10]:5 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266083AbUEUWdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:01 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, brettspamacct@fastclick.com
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64
 specifically)?
References: <1Y6yr-eM-11@gated-at.bofh.it> <1YbRm-4iF-11@gated-at.bofh.it>
	<1Yma3-4cF-3@gated-at.bofh.it> <1YmjP-4jX-37@gated-at.bofh.it>
	<1YmMN-4Kh-17@gated-at.bofh.it> <1Yn67-50q-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 21 May 2004 21:19:46 +0200
In-Reply-To: <1Yn67-50q-7@gated-at.bofh.it> (Martin J. Bligh's message of
 "Fri, 21 May 2004 20:40:07 +0200")
Message-ID: <m3lljld1v1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> For any given situation, you can come up with a scheduler mod that improves
> things. The problem is making something generic that works well in most
> cases. 

The point behind numa api/numactl is that if the defaults
don't work well enough you can tune it by hand to be better.

There are some setups which can be significantly improved with some
hand tuning, although in many cases the default behaviour is good enough
too.

-Andi

