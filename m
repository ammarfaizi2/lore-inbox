Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUDBVLB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264179AbUDBVLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:11:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:32737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264121AbUDBVLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:11:00 -0500
Date: Fri, 2 Apr 2004 13:13:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
Message-Id: <20040402131309.238729bb.akpm@osdl.org>
In-Reply-To: <406DD2E2.7030602@A88be.a.pppool.de>
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
	<20040328200710.66a4ae1a.akpm@osdl.org>
	<4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de>
	<1080570227.20685.93.camel@watt.suse.com>
	<406D21F6.8080005@A88c0.a.pppool.de>
	<20040402022348.00d55268.akpm@osdl.org>
	<406DD2E2.7030602@A88be.a.pppool.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@freenet.de> wrote:
>
> > What device drivers are running at the time?  disk/network/usb/etc?
> 
> Module                  Size  Used by    Not tainted
> eepro100               19828   1  (autoclean)
> mii                     2480   0  (autoclean) [eepro100]
> sis900                 13036   1  (autoclean)
> crc32                   2880   0  (autoclean) [sis900]
> usb-storage            26416   0  (unused)
> scsi_mod               87488   0  [usb-storage]
> uhci                   25436   0  (unused)
> usbcore                62316   0  [usb-storage uhci]
> lvm-mod                44416  12  (autoclean)
> unix                   15308  13  (autoclean)

No.  I mean which drivers were actually doing significant amounts of work
during the test?

(you appear to not have any disks)
