Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVHCOX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVHCOX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVHCOX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:23:59 -0400
Received: from outmx010.isp.belgacom.be ([195.238.3.233]:60618 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261636AbVHCOXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:23:53 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Wed, 3 Aug 2005 16:23:59 +0200
User-Agent: KMail/1.8.1
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <200508031354.52972.lkml@kcore.org> <200508032214.45451.kernel@kolivas.org>
In-Reply-To: <200508032214.45451.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031624.00319.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 14:14, Con Kolivas wrote:
> On Wed, 3 Aug 2005 21:54, Jan De Luyck wrote:
> > On Wednesday 03 August 2005 07:59, Con Kolivas wrote:
> > > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > > <tony@atomide.com> and Tuukka Tikkanen
> > > <tuukka.tikkanen@elektrobit.com>. Patch for 2.6.13-rc5
> >
> > Compiles and runs ok here.
> >
> > Is there actually any timer frequency that's advisable to set as maximum?
> > (in the kernel config)
>
> I'd recommend 1000.

Thanks. Currently the system - under X, KDE, no artsd, bottoms at around 
300HZ. In total single mode with every module unloaded that I can unload it 
stops around 22HZ.

I guess I'll have to go hunting whatever thing is causing the pollings. no 
timertop yet, I guess? :P

Jan

-- 
If you give Congress a chance to vote on both sides of an issue, it
will always do it.
		-- Les Aspin, D., Wisconsin
