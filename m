Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272809AbTG3IBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 04:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272810AbTG3IBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 04:01:38 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:18155 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S272809AbTG3IBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 04:01:37 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux kernel <linux-kernel@vger.kernel.org>
Date: Wed, 30 Jul 2003 01:00:01 -0700 (PDT)
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <20030730071417.GM13611@Synopsys.COM>
Message-ID: <Pine.LNX.4.44.0307300058490.24695-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

are you really sure the kernel default is to blank?

on my slackware systems there is a setterm -blank 15 in the startup
scripts and all I have ever needed to do (1.2 through 2.4 kernels) is to
comment this out and the screen never blanks.

David Lang


On Wed, 30 Jul 2003, Alex Riesen wrote:

> Date: Wed, 30 Jul 2003 09:14:17 +0200
> From: Alex Riesen <alexander.riesen@synopsys.COM>
> To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> Cc: Linux kernel <linux-kernel@vger.kernel.org>
> Subject: Re: Turning off automatic screen clanking
>
> Zwane Mwaikambo, Wed, Jul 30, 2003 03:37:26 +0200:
> > On Wed, 30 Jul 2003, Jamie Lokier wrote:
> >
> > > One of Richard's points is that there is presently no way to fix the
> > > box in userspace.  If the kernel crashes during boot, it will blank
> > > the screen and there is no way to unblank it in that state.
> >
> > Well something like this should work without complicating things during
> > panic.
> >
>
> Does it unblank screen if panic happened while the screen was blanked?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
