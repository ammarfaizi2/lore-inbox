Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUHIObE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUHIObE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUHIO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:28:32 -0400
Received: from zero.aec.at ([193.170.194.10]:50180 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266611AbUHIO2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:28:19 -0400
To: Bob Deblier <bob.deblier@telenet.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: AES assembler optimizations
References: <2riR3-7U5-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 09 Aug 2004 16:28:13 +0200
In-Reply-To: <2riR3-7U5-3@gated-at.bofh.it> (Bob Deblier's message of "Mon,
 09 Aug 2004 16:00:09 +0200")
Message-ID: <m3d620v11e.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Deblier <bob.deblier@telenet.be> writes:

> Just picked up on KernelTrap that there were some problems with
> optimized AES code; if you wish, I can provide my own LGPL licensed (or
> I can relicense them for you under GPL), as included in the BeeCrypt
> Cryptography Library.
>
> I have generic i586 code and SSE-optimized code available in GNU
> assembler format. Latest version is always available on SourceForge
> (http://sourceforge.net/cvs/?group_id=8924).

Would be interesting.  Do you have any benchmarks for your code?

However I think we would need to get rid of the M4 first. I don't
think it would be a good idea to add that as kernel build dependency.
Linux kernel assembly normally uses the C preprocessor and modern gas
also has a quite powerful macro facility that is usually good
enough. Any chance to convert the code to one of these?

-Andi


