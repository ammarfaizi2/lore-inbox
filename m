Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVEDU55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVEDU55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVEDU5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:57:16 -0400
Received: from smtpout.mac.com ([17.250.248.87]:60112 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261650AbVEDUzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:55:50 -0400
In-Reply-To: <87fyx2vp4i.fsf@mail.gatech.edu>
References: <87vf5y99o3.fsf@mail.gatech.edu> <42790A86.9070002@didntduck.org> <87fyx2vp4i.fsf@mail.gatech.edu>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FBE10E17-C501-4182-9B51-554A37362D10@mac.com>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: macro in linux/compiler.h pollutes gcc __attribute__ namespace
Date: Wed, 4 May 2005 16:55:53 -0400
To: Timmy Douglas <timmy+lkml@cc.gatech.edu>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 4, 2005, at 14:10:21, Timmy Douglas wrote:
> I'm guessing it goes sort of like this:
>
> signal.h -> bits/sigcontext.h -> asm/sigcontext.h -> linux/compiler.h

Installing headers directly from the kernel has been deprecated for
quite a while.  Please look for the "linux-kernel-headers" package in
whatever your package management system is.  It has a set of cleaned
headers.  IIRC, there were some proposals a while back for how to fix
this and make a set of headers useable from userspace, but nothing
substantial ever got done.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



