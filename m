Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUHVB3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUHVB3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 21:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUHVB3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 21:29:13 -0400
Received: from zero.aec.at ([193.170.194.10]:10246 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264984AbUHVB3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 21:29:12 -0400
To: "James M." <dart@windeath.2y.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Obvious one-liner - Use 3DNOW on MK8
References: <2vOfA-7Vg-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 22 Aug 2004 03:29:08 +0200
In-Reply-To: <2vOfA-7Vg-7@gated-at.bofh.it> (James M.'s message of "Sun, 22
 Aug 2004 02:20:06 +0200")
Message-ID: <m34qmwx8nv.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James M." <dart@windeath.2y.net> writes:

> Title says it...my Athlon 64 definitely uses 3DNOW. Patch changes
> arch/i386/Kconfig and has a 3 line fudge factor(I created it a few
> kernels back). Might want to check other arches for the same bug.

It it's not a bug, it is a feature. The K8 is better off not using 
the 3dnow memcpy, which is the only feature this CONFIG controls.

Please don't apply.

-Andi

