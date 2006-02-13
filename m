Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWBMUKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWBMUKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWBMUKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:10:42 -0500
Received: from mail.gmx.de ([213.165.64.21]:59862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964830AbWBMUKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:10:41 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 21:10:38 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.4 ide-cd causes 'local unit communication failure' on NEC ND-4550A?
Message-ID: <20060213201038.GB22578@merlin.emma.line.org>
Mail-Followup-To: axboe@suse.de, linux-kernel@vger.kernel.org
References: <20060212155258.GA8860@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212155258.GA8860@merlin.emma.line.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree schrieb am 2006-02-12:

> Greetings,
> 
> catchy subject, here's the story:
> 
> SUSE Linux kernels 2.6.13-15.7,
>                    2.6.13-15.8 (both SUSE Linux 10.0 i586) and
> Vanilla    kernel  2.6.15.4
> 
> cause "local unit communication failure" when running "readcd -c2scan"
> on my NEC ND-4550A CD/DVD drive (VIA KT8237, Athlon XP 2500+, 1 GB RAM)
> after at most two seconds of reading.

Detail info: the failed command always takes a touch more than 6.4 s to
timeout. Only the time until it happens for the first time differs.
It appears to me that the drive has an internal watchdog to wait for the
host to do something.

And directions how to dig up useful debug information for this issue?
Have there been related fixes in 2.6.16-rc* that make testing
worthwhile?

-- 
Matthias Andree
