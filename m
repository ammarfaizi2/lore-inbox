Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263684AbUDGOjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbUDGOiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:38:03 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:15300 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263684AbUDGOh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:37:56 -0400
Date: Wed, 7 Apr 2004 10:38:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_4KSTACKS in mm2?
In-Reply-To: <20040407140346.GC32088@charite.de>
Message-ID: <Pine.LNX.4.58.0404071037341.16677@montezuma.fsmlabs.com>
References: <20040407135551.GA32088@charite.de>
 <Pine.LNX.4.58.0404071000340.16677@montezuma.fsmlabs.com>
 <20040407140346.GC32088@charite.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Ralf Hildebrandt wrote:

> * Zwane Mwaikambo <zwane@linuxpower.ca>:
>
> > > Is there a way of disabling CONFIG_4KSTACKS in 2.6.5-mm2?
> > > Or to make it configurable?
> >
> > "arch/i386/Kconfig" line 1498 of 1542 --97%-- col 8
> > config 4KSTACKS
> >         def_bool y
> >
> > you could just change that to 'n'
>
> That's what I did (and it works) -- but it's not really intuitive or
> even configurable (in the way of menuconfig or something).

Andrew Morton turned it on unconditionally on purpose for wider testing.
