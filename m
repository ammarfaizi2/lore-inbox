Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319629AbSH3Reo>; Fri, 30 Aug 2002 13:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319630AbSH3Reo>; Fri, 30 Aug 2002 13:34:44 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:14025 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319629AbSH3Ren>;
	Fri, 30 Aug 2002 13:34:43 -0400
Date: Fri, 30 Aug 2002 10:39:07 -0700
To: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: wavelan_cs.c in linux-2.4.20-pre5
Message-ID: <20020830173907.GA15469@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020830183658.A1821@birdsnest.maths.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830183658.A1821@birdsnest.maths.tcd.ie>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 06:36:59PM +0100, Timothy Murphy wrote:
> I'm not quite sure if you are responsible for this driver,
> but I thought I would mention that I had to #include <linux/types.h>
> in wavelan_cs.c to compete compilation of the kernel,
> after getting warnings that seemed to imply u32 was undefined.

	That's the wrong fix. #include <linux/types.h> is already
available in wavelan.p.h. Those includes should be moved there as
well.

	Jean

