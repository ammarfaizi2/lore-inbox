Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267232AbTAKOgS>; Sat, 11 Jan 2003 09:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTAKOgS>; Sat, 11 Jan 2003 09:36:18 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:32920 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267232AbTAKOgS>; Sat, 11 Jan 2003 09:36:18 -0500
Date: Sat, 11 Jan 2003 15:44:13 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>,
       jgarzik@pobox.com, mantel@suse.de, Natalie.Protasevich@UNISYS.com,
       linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?
Message-ID: <20030111144413.GA20364@averell>
References: <20030109224013$6e5e@gated-at.bofh.it> <20030111110011$3252@gated-at.bofh.it> <m3n0m729bb.fsf@averell.firstfloor.org> <20030111142839.A29018@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111142839.A29018@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 03:28:40PM +0100, Christoph Hellwig wrote:
> On Sat, Jan 11, 2003 at 12:51:52PM +0100, Andi Kleen wrote:
> > openssl is only compiled as a module in released kernels, so it is similar to
> > the PPP BSD compression module.
> 
> It compiles parts of openssl which explicitly have a license that conflicts
> with the GPL when CONFIG_PPP=y.  The bsd_comp stuff was only compilable as
> module.

I guess you meant CONFIG_CIPHER_TWOFISH, not CONFIG_PPP. 

Yes it can be compiled in, but UnitedLinux does not do so - the kernel
rpm compiles it as a module.

-Andi
