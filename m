Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbUDNMO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbUDNMO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:14:28 -0400
Received: from zero.aec.at ([193.170.194.10]:34059 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264060AbUDNMOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:14:23 -0400
To: Tim Hockin <thockin@hockin.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
References: <1KNjN-gZ-9@gated-at.bofh.it> <1KNDc-Bv-9@gated-at.bofh.it>
	<1KNDg-Bv-25@gated-at.bofh.it> <1KNMQ-Hs-15@gated-at.bofh.it>
	<1KNWA-OH-25@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 14 Apr 2004 14:14:16 +0200
In-Reply-To: <1KNWA-OH-25@gated-at.bofh.it> (Tim Hockin's message of "Wed,
 14 Apr 2004 10:30:12 +0200")
Message-ID: <m3llkyoixz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@hockin.org> writes:
>
> arch/*/Kconfig
> 	libpath /Kconfig.lib
> 	...
> 	insert DEBUG_BUFFERS
> 	...
>
> If the inserted symbol is not found in the Kconfig libpath, error out.
> You can then break debug Kconfigs into a separate lib file, etc.  Maybe
> that's too far, but you get the idea?

Sounds like a good idea to me. It would clean up the Kconfigs a lot.
Includes are often not finegrained enough.

-Andi

