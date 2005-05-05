Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVEECJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVEECJW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 22:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVEECJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 22:09:22 -0400
Received: from deliverator6.gatech.edu ([130.207.165.168]:25838 "EHLO
	deliverator6.gatech.edu") by vger.kernel.org with ESMTP
	id S261799AbVEECJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 22:09:16 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: macro in linux/compiler.h pollutes gcc __attribute__ namespace
References: <87vf5y99o3.fsf@mail.gatech.edu> <42790A86.9070002@didntduck.org>
	<87fyx2vp4i.fsf@mail.gatech.edu>
	<FBE10E17-C501-4182-9B51-554A37362D10@mac.com>
From: Timmy Douglas <timmy+lkml@cc.gatech.edu>
Date: Wed, 04 May 2005 22:08:46 -0400
In-Reply-To: <FBE10E17-C501-4182-9B51-554A37362D10@mac.com> (Kyle Moffett's
	message of "Wed, 4 May 2005 16:55:53 -0400")
Message-ID: <87br7qv2z5.fsf@mail.gatech.edu>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On May 4, 2005, at 14:10:21, Timmy Douglas wrote:
>> I'm guessing it goes sort of like this:
>>
>> signal.h -> bits/sigcontext.h -> asm/sigcontext.h -> linux/compiler.h
>
> Installing headers directly from the kernel has been deprecated for
> quite a while.  Please look for the "linux-kernel-headers" package
> in whatever your package management system is.  It has a set of
> cleaned headers.  IIRC, there were some proposals a while back for
> how to fix this and make a set of headers useable from userspace,
> but nothing substantial ever got done.

Thanks for the input. It seems this is a gentoo bug then because it
leaves this #define in their version of the source (even though it
removes some other things). I don't see this problem on a debian box I
have though. Too bad this wasn't standardized on.

Thanks again.

