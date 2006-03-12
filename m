Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWCLR5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWCLR5K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCLR5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:57:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27367 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751430AbWCLR5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:57:08 -0500
Subject: Re: IDE CDROM - No DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Chris Boot <bootc@bootc.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <200603121209.33218.kernel-stuff@comcast.net>
References: <200603101842.09251.kernel-stuff@comcast.net>
	 <200603120128.44469.kernel-stuff@comcast.net> <441443F5.1060603@bootc.net>
	 <200603121209.33218.kernel-stuff@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Mar 2006 18:03:00 +0000
Message-Id: <1142186580.20056.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-03-12 at 12:09 -0500, Parag Warudkar wrote:
> Some one pointed out offline -
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=163418 
> 
> Looks like it's a SATA combined mode problem as outlined in the above bug 
> report. NONE of the options provided in the bug report worked for me though -
> :(

If you feel adventurous then apply the libata PATA patch from my web
page and compile a kernel with CONFIG_IDE=n and most stuff should work.
Folks are still reporting some problems with libata and CD burning
however.

