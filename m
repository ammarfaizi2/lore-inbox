Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWADU4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWADU4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWADU4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:56:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030285AbWADU43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:56:29 -0500
Date: Wed, 4 Jan 2006 15:56:16 -0500
From: Dave Jones <davej@redhat.com>
To: gcoady@gmail.com
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060104205616.GA9754@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, gcoady@gmail.com,
	Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <lgcor1pdtr85jl28g02i2sddakqcd2fu35@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lgcor1pdtr85jl28g02i2sddakqcd2fu35@4ax.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 07:38:29AM +1100, Grant Coady wrote:
 > On Wed, 4 Jan 2006 14:05:54 -0500, Dave Jones <davej@redhat.com> wrote:
 > 
 > >On Wed, Jan 04, 2006 at 12:00:00PM +1100, Con Kolivas wrote:
 > > >  +2.6.15-dynticks-060101.patch
 > > >  +dynticks-disable_smp_config.patch
 > > > Latest version of the dynticks patch. This is proving stable and effective on 
 > > > virtually all uniprocessor machines and will benefit systems that desire 
 > > > power savings. SMP kernels (even on UP machines) still misbehave so this 
 > > > config option is not available by default for this stable kernel.
 > >
 > >I've been curious for some time if this would actually show any measurable
 > >power savings. So I hooked up my laptop to a gizmo[1] that shows how much
 > >power is being sucked.
 > >
 > >both before, and after, it shows my laptop when idle is pulling 21W.
 > >So either the savings here are <1W (My device can't measure more accurately
 > >than a single watt), or this isn't actually buying us anything at all, or
 > >something needs tuning.
 > 
 > Or the laptop was still recharging the battery in both cases?

No, I made sure it was fully charged (and the charging light was off)
before I started tests.  I was tricked by the fact that you have to
wait a while before things start happening.

		Dave


