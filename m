Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131660AbQKJUg0>; Fri, 10 Nov 2000 15:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131712AbQKJUgS>; Fri, 10 Nov 2000 15:36:18 -0500
Received: from [64.64.109.142] ([64.64.109.142]:36367 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131660AbQKJUgA>; Fri, 10 Nov 2000 15:36:00 -0500
Message-ID: <3A0C5BB2.3C48C251@didntduck.org>
Date: Fri, 10 Nov 2000 15:33:54 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <Pine.LNX.4.21.0011101937510.552-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> 
> On Fri, 10 Nov 2000, Brian Gerst wrote:
> 
> > > features        : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
> >
> > The K6's don't support sysenter/sysexit.
> 
> The K6 datasheets suggests otherwise.
> Some models seem to have sysenter/sysexit, whilst others have
> syscall/sysret. No model seems to have both.
> 
> The datasheets are somewhat confusing, as it doesn't mention bit 10
> at all, just an oversized box for bit 11.

The Athlons support sysenter and syscall, but the K6's only support
syscall.  The earlier version of syscall (bit 10) is undocumented by
AMD.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
