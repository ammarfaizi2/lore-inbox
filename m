Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUAOVJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUAOVJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:09:43 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:63918 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263903AbUAOVIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:08:51 -0500
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org>
	<87hdyyxjgl.fsf@stark.xeocode.com>
	<20040114225653.GA32704@codepoet.org>
	<4005D195.3010008@inp-net.eu.org> <4005D9E7.2070203@bigfoot.com>
	<1074134345.6094.11.camel@mhcln02>
In-Reply-To: <1074134345.6094.11.camel@mhcln02>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 15 Jan 2004 16:08:49 -0500
Message-ID: <87wu7s2a3i.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthias Hentges <mailinglisten@hentges.net> writes:

> Notice the unusual BIOS setting (Enhanced Mode - SATA only) which did
> the trick and enabled PATA *and* SATA.
> You may want to try that if you haven't already.

Thank you!

That was the key thing I was missing. With this setting the PATA drives show
up on /dev/hd{a,b,c,d} and the SATA drives show up on /dev/sd{a,b} (using
ata_piix). And everything seems to work pretty well in 2.6.1.

I've only tried the PATA hard drive and reading from cdrom. I haven't tried
burning cds or playing a dvd yet. 

-- 
greg

