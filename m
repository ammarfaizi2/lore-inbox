Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264986AbUFALhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbUFALhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUFALhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:37:50 -0400
Received: from holomorphy.com ([207.189.100.168]:42383 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264986AbUFALhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:37:47 -0400
Date: Tue, 1 Jun 2004 04:37:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dominik Karall <dominik.karall@gmx.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601113736.GP2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dominik Karall <dominik.karall@gmx.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <200406011248.16303.dominik.karall@gmx.net> <20040601112418.GM2093@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601112418.GM2093@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 04:24:18AM -0700, William Lee Irwin III wrote:
> There's a plot down there I don't completely understand. Until those
> who know what's going on materialize:

While I'm at it, I might as well


Index: linux-2.6.7-rc2-mm1/drivers/scsi/sr_ioctl.c
===================================================================
--- linux-2.6.7-rc2-mm1.orig/drivers/scsi/sr_ioctl.c	2004-06-01 04:12:12.000000000 -0700
+++ linux-2.6.7-rc2-mm1/drivers/scsi/sr_ioctl.c	2004-06-01 04:36:09.000000000 -0700
@@ -545,5 +545,4 @@
 {
 	Scsi_CD *cd = cdi->handle;
 	return scsi_ioctl(cd->device, cmd, (void __user *)arg);
-	return scsi_ioctl(cd->device, cmd, (void __user *)arg);
 }
