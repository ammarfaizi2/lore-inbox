Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSKLMJr>; Tue, 12 Nov 2002 07:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSKLMJr>; Tue, 12 Nov 2002 07:09:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26126 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266527AbSKLMJq>; Tue, 12 Nov 2002 07:09:46 -0500
Date: Tue, 12 Nov 2002 13:16:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021112121633.GB21443@atrey.karlin.mff.cuni.cz>
References: <johnstul@us.ibm.com> <1037047250.1625.5.camel@cornchips> <200211112057.gABKvS620539@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211112057.gABKvS620539@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> As a beginning, what about the attached patch?  It eliminates the compile time 
> TSC options (and thus hopefully the sources of confusion).  I've exported 
> tsc_disable, so it can be set by the subarchs if desired (voyager does this) 
> and moved the notsc option into the timer_tsc code (which is where it looks 
> like it belongs).

Looks good to me.
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
