Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbQKJTup>; Fri, 10 Nov 2000 14:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbQKJTuf>; Fri, 10 Nov 2000 14:50:35 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:50423 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S131631AbQKJTuT>; Fri, 10 Nov 2000 14:50:19 -0500
From: davej@suse.de
Date: Fri, 10 Nov 2000 19:49:52 +0000 (GMT)
To: Brian Gerst <bgerst@didntduck.org>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <3A0C435C.A31A38EC@didntduck.org>
Message-ID: <Pine.LNX.4.21.0011101937510.552-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Brian Gerst wrote:

> > features        : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
> 
> The K6's don't support sysenter/sysexit.

The K6 datasheets suggests otherwise.
Some models seem to have sysenter/sysexit, whilst others have
syscall/sysret. No model seems to have both.

The datasheets are somewhat confusing, as it doesn't mention bit 10
at all, just an oversized box for bit 11.

> It really should have been marked differently before.

Before we weren't mentioning it at all, look..
flags  : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow

> The early K6's used extended bit 10 to indicate syscall/sysret
> capabality, but this version has some quirks that make it pretty much
> unusable.  Later K6's use extended bit 11 to indicate syscall/sysret.

And where does sysenter/sysexit fit in?

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
