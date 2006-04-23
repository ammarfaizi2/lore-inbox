Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWDWMnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWDWMnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWDWMnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:43:20 -0400
Received: from silver.veritas.com ([143.127.12.111]:36192 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751401AbWDWMnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:43:20 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,149,1144047600"; 
   d="scan'208"; a="37489478:sNHT23579008"
Date: Sun, 23 Apr 2006 13:42:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Chris Ball <cjb@mrao.cam.ac.uk>
cc: Pavel Machek <pavel@suse.cz>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <yd3bquuqz0y.fsf@islay.ra.phy.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0604231341310.2515@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz>
 <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
 <20060421163930.GA1648@elf.ucw.cz> <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
 <yd3bquuqz0y.fsf@islay.ra.phy.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Apr 2006 12:42:53.0635 (UTC) FILETIME=[7063A930:01C666D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Apr 2006, Chris Ball wrote:
> 
> FWIW, this patch fixes S3 resume for me too.  I'm on an Alienware m5500
> using sd_mod and ata_piix, and I think your T43p is using AHCI, so it
> seems that this fixes a libata-wide problem rather than something 
> specific to your hardware.

Thanks for the info, that is useful; but in fact I'm ata_piix not ahci.

Hugh
