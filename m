Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUGPRKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUGPRKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUGPRKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:10:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18615 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266598AbUGPRKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:10:38 -0400
Date: Fri, 16 Jul 2004 17:35:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Kotowicz <koto-lkml@mynetix.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend to disk breaks e100 driver kernel 2.6.7 and 2.6.8-rc1
Message-ID: <20040716153527.GA8264@openzaurus.ucw.cz>
References: <1089641949.13037.5.camel@saturn.koto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089641949.13037.5.camel@saturn.koto.lan>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> whenever I put my notebook into suspend to disk by calling "echo -n disk
> > /sys/power/state" my network connection dies.
> this is what I get in the logs:
...
...
> taking the network connection down, removing the modules and reinserting
> it, doesn't help. I have to reboot the notebook for the network to work
> again.
> 
> this didn't happen with kernel 2.6.6 and prior versions.

Try copying e100 driver from 2.6.6 into recent kernel and/or try
using swsusp instead of pmdisk.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

