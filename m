Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWIMR63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWIMR63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWIMR62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:58:28 -0400
Received: from www.osadl.org ([213.239.205.134]:56254 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750878AbWIMR62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:58:28 -0400
Subject: Re: RT, timers and CLOCK_REALTIME_HR
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609131712.26350.Serge.Noiraud@bull.net>
References: <200609131712.26350.Serge.Noiraud@bull.net>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 19:59:07 +0200
Message-Id: <1158170348.5724.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 17:12 +0200, Serge Noiraud wrote:
> Hi,
> 
> 	I have one question about CLOCK_REALTIME_HR. 
> Before the rt patch I used to work with this clock. ie : hrtimers-support-3.1.1
> 
> With the rt patch it seems CLOCK_REALTIME_HR does not exist anymore !
> Is this normal ?

Yes, we removed it a while ago. Same for CLOCK_MONOTONIC_HR.

> The kernel speaks about that in arch/ia64/Kconfig
> perhaps it should be removed !

Yep.

> I had a libtimers using this clock.
> 
> Is the good correction to say CLOCK_REALTIME_HR = CLOCK_REALTIME ?
> I don't want to modify all my programs.

Probably that's the best hack for you.

	tglx


