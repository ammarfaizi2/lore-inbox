Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266811AbUBMIiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 03:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUBMIiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 03:38:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37133 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S266811AbUBMIix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 03:38:53 -0500
Date: Fri, 13 Feb 2004 09:37:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Message-ID: <20040213083718.GA11914@alpha.home.local>
References: <200402122106.41947.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402122106.41947.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Thu, Feb 12, 2004 at 09:06:41PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Willy, it seems you are hitting some other problem.
> Have you already tried booting with "ide0=ata66"?

Sorry, I think I mangled it like "hda=ata66" or "ide0=udma66" instead when I
tried. I just rechecked with "ide0=ata66", and I confirm that it works (it
uses UDMA100). BTW, wouldn't it be more appropriate to use something such as
"udma4" or "80pin" or something else which would be more intuitive than
"ata66" ?

Thanks for your help and particularly for your quick response, Bart.
Willy

