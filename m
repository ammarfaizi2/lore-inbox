Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266981AbTBCTFv>; Mon, 3 Feb 2003 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTBCTFv>; Mon, 3 Feb 2003 14:05:51 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:18896 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S266981AbTBCTFu>;
	Mon, 3 Feb 2003 14:05:50 -0500
Date: Mon, 3 Feb 2003 13:14:56 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU throttling??
Message-Id: <20030203131456.34c04df8.arashi@arashi.yi.org>
In-Reply-To: <200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
References: <200302031713.h13HD2K8000181@darkstar.example.net>
	<200302031857.h13IvHa0025735@turing-police.cc.vt.edu>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Feb 2003 13:57:17 -0500
Valdis.Kletnieks@vt.edu wrote:

> On Mon, 03 Feb 2003 17:13:02 GMT, John Bradford said:
> 
> > Incidently, Linux has always halted the processor, rather than spun in
> > an idle loop, which saves power.
> 
> It's conceivable that a CPU halted at 1.2Gz takes less power than one
> at 1.6Gz - anybody have any actual data on this?  Alternately phrased,
> does CPU throttling save power over and above what the halt does?

Yes. I have a powerpc laptop that runs at 700 MHz. If I throttle the CPU clock
speed down to 400 MHz and change nothing else the battery has noticeably longer
life; since it's running slower, it takes less power when it's active (not
halted).

Matt
