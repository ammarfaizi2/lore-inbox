Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTIMHXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 03:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTIMHXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 03:23:30 -0400
Received: from ns.suse.de ([195.135.220.2]:47321 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262064AbTIMHX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 03:23:29 -0400
Date: Sat, 13 Sep 2003 09:23:27 +0200
From: Andi Kleen <ak@suse.de>
To: Milton Miller <miltonm@bga.com>
Cc: Patrick Mochel <mochel@osdl.org>, Andi Kleen <ak@suse.de>,
       Daniel Blueman <daniel.blueman@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [linux-2.4.0-test5] swsusp w/o swap fail...
Message-ID: <20030913072327.GA23992@wotan.suse.de>
References: <Pine.LNX.4.33.0309121509120.984-100000@localhost.localdomain> <200309130349.h8D3nTvG035109@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309130349.h8D3nTvG035109@sullivan.realtime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 10:49:29PM -0500, Milton Miller wrote:
> To fix bugzilla 1131, Andi added select SOFTWARE_SUSPEND when ACPI_SLEEP
> is selected.  However, as discussed elsewhere [1], select superceedes
> depends.  Rather than say ACPI_SLEEP also enables SWAP, how about having
> X86_64 pick up a change made to x86, and compile suspend.c on CONFIG_PM.
> 
> Andi, can you test this?

That won't work. suspend won't compile without suspend_asm

-Andi
