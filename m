Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUE2Kv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUE2Kv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 06:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUE2Kv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 06:51:56 -0400
Received: from zero.aec.at ([193.170.194.10]:32774 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264247AbUE2Kvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 06:51:55 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
References: <218aB-15c-17@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 29 May 2004 12:51:52 +0200
In-Reply-To: <218aB-15c-17@gated-at.bofh.it> (Francois Romieu's message of
 "Sat, 29 May 2004 11:20:09 +0200")
Message-ID: <m3brk7pktz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> writes:

> The linux kernel README and Documentation/CHANGES suggests to use
> gcc 2.95.3. These files have not been updated for ages. Is there
> a rough consensus regarding the required versions of the different
> tools in the buildchain or should one simply submit a patch to remove
> the offending files ?

I would suggest to just remove them. We're past the state when each new
compiler version broke the kernel. Originally that was a lot due 
to buggy inline assembly etc., but that should be all fleshed out now.

> I forgot to mention: 2.95.3 does not compile correctly the 2.6.6 r8169
> driver.

Make it an #error then. Better a compile time error than a mysterious
malfunction.

-Andi

