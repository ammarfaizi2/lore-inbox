Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752076AbWCNMoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbWCNMoT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWCNMoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:44:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22508 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752076AbWCNMoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:44:19 -0500
Date: Tue, 14 Mar 2006 13:43:49 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Jun OKAJIMA <okajima@digitalinfra.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Message-ID: <20060314124348.GR10870@elf.ucw.cz>
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603141613.10915.kernel@kolivas.org> <20060314115145.GL10870@elf.ucw.cz> <200603142333.12988.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603142333.12988.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 14-03-06 23:33:12, Con Kolivas wrote:
> On Tuesday 14 March 2006 22:51, Pavel Machek wrote:
> > > Since my warning probably scared anyone from actually trying this patch
> > > I've given it a thorough working over on my own laptop, booting with
> > > mem=128M. The patch works fine and basically with the patch after
> > > resuming from disk I have 25MB more memory in use with pages prefetched
> > > from swap. This makes a noticeable difference to me. That's a pretty
> > > artificial workload, so if someone who actually has lousy wakeup after
> > > resume could test the patch it would be appreciated.
> >
> > Thanks for the patch...
> >
> > BTW.. if you want this maximally useful, it would be nice to have
> > userspace interface for this.
> 
> What sort of interface is suitable? There's a swap_prefetch tunable that is a 
> boolean but I could make that to be off=0, on=1, aggressive_prefetch=2 or 
> something. 

That sounds nice.
									Pavel
-- 
116:
