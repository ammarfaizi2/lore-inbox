Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbTHSXgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbTHSXgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:36:03 -0400
Received: from zero.aec.at ([193.170.194.10]:37382 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261496AbTHSXgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:36:01 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-rc2] x86-64 register_ioctl32_conversion() breakage
From: Andi Kleen <ak@muc.de>
Date: Wed, 20 Aug 2003 01:35:52 +0200
In-Reply-To: <mnM6.1z1.7@gated-at.bofh.it> (Mikael Pettersson's message of
 "Wed, 20 Aug 2003 01:10:10 +0200")
Message-ID: <m31xvhrzjb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <mnM6.1z1.7@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Either ia32_ioctl.c or the comment in ioctl32.h is wrong and should
> be fixed. I'd prefer the code to work as in 2.6 since that avoids
> #if LINUX_VERSION_CODE crap and dummy ioctl handlers.

I fixed it in x86-64.org CVS for 2.4, but it will take some time
to propagate into the various trees. I doubt it will be in 
2.4.22-final.

-Andi

P.S.: The better list would be discuss@x86-64.org, not l-k
