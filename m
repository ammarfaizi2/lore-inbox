Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965252AbWADUiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbWADUiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbWADUiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:38:46 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:712 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965252AbWADUiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:38:46 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Dave Jones <davej@redhat.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Date: Thu, 05 Jan 2006 07:38:29 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <lgcor1pdtr85jl28g02i2sddakqcd2fu35@4ax.com>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com>
In-Reply-To: <20060104190554.GG10592@redhat.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 14:05:54 -0500, Dave Jones <davej@redhat.com> wrote:

>On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
> >  +2.6.15-dynticks-060101.patch
> >  +dynticks-disable_smp_config.patch
> > Latest version of the dynticks patch. This is proving stable and effective on 
> > virtually all uniprocessor machines and will benefit systems that desire 
> > power savings. SMP kernels (even on UP machines) still misbehave so this 
> > config option is not available by default for this stable kernel.
>
>I've been curious for some time if this would actually show any measurable
>power savings. So I hooked up my laptop to a gizmo[1] that shows how much
>power is being sucked.
>
>both before, and after, it shows my laptop when idle is pulling 21W.
>So either the savings here are <1W (My device can't measure more accurately
>than a single watt), or this isn't actually buying us anything at all, or
>something needs tuning.

Or the laptop was still recharging the battery in both cases?

Grant.
