Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWH1TFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWH1TFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWH1TFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:05:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38037 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751338AbWH1TFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:05:48 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: "Miles Lane" <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4-mm3 -- intel8x0 audio busted
References: <a44ae5cd0608262355q51279259lc6480f229e520fd5@mail.gmail.com>
	<s5hac5o7v47.wl%tiwai@suse.de> <20060828114939.90341479.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2006 21:05:46 +0200
In-Reply-To: <20060828114939.90341479.akpm@osdl.org>
Message-ID: <p737j0s7kad.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> 
> No, they're just a little warning we put in there to find out how
> removeable sys_sysctl() is.  (Answer: not very.  I'll drop that patch).

I made the same experiment some time ago -- all of them use only a single
sysctl (KERN_VERSION). If that one is emulated there are basically no users 
left. I can resend a patch to warn only for those that are not KERN_VERSION
if there is interest.

-Andi
