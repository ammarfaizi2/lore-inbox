Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUDSPgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUDSPgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:36:40 -0400
Received: from zero.aec.at ([193.170.194.10]:21515 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264266AbUDSPgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:36:31 -0400
To: Jan Kasprzak <kas@informatics.muni.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 bad frame in signal deliver
References: <1MHWN-3ga-31@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 19 Apr 2004 17:36:28 +0200
In-Reply-To: <1MHWN-3ga-31@gated-at.bofh.it> (Jan Kasprzak's message of
 "Mon, 19 Apr 2004 16:30:17 +0200")
Message-ID: <m3ad18m137.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@informatics.muni.cz> writes:
>
> 	Does that mean that proftpd segfaulted inside user space (and is thus
> buggy or even insecure) - as address rip:41ecaa suggests, or is it some kind
> of kernel bug?

Yes, we know every message that isn't output by i386 is a kernel bug.

proftpd segfaulted.

-Andi

