Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284618AbRLDAUv>; Mon, 3 Dec 2001 19:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284880AbRLDASQ>; Mon, 3 Dec 2001 19:18:16 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:4614 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S282993AbRLCJ0X>; Mon, 3 Dec 2001 04:26:23 -0500
Date: Mon, 3 Dec 2001 09:19:57 +0000
From: Alan Ford <alan@whirlnet.co.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-pre2 & PCMCIA Errors
Message-ID: <20011203091956.A669@whirlnet.co.uk>
In-Reply-To: <20011202203207.A1014@whirlnet.co.uk> <15370.65477.649725.353028@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15370.65477.649725.353028@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 03:29:57PM +1100, Paul Mackerras wrote:
> Alan Ford writes:
> 
> > Just tried 2.4.17-pre2 (was previously on 2.4.16-pre1) and when pcmcia-cs is
> > started on bootup, the following happens:
> > 
> > cs: IO port probe 0x0c00-0x0cff: clean.
> > cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
> > cs: IO port probe 0x0a00-0x0aff: clean.
> > cs: memory probe 0xa0000000-0xa0ffffff:<1>Unable to handle kernel NULL pointer
> > dereference at virtual address 00000004
> 
> Please try this patch and let me know whether it fixes the problem.

Thank you, that appears to fix the problem.

The disks are also unmounted correctly now, so that problem was probably
caused by the kernel getting in a mess (excuse my non-technical language)
over this pcmcia stuff.

-- 
Alan Ford * alan@whirlnet.co.uk 
