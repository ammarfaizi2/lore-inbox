Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUBYObE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUBYO3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:29:34 -0500
Received: from mail.ccur.com ([208.248.32.212]:63753 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261338AbUBYO3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:29:20 -0500
Date: Wed, 25 Feb 2004 09:29:19 -0500
From: Joe Korty <joe.korty@ccur.com>
To: "Moore, Eric Dean" <Emoore@lsil.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <20040225142919.GA11091@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <0E3FA95632D6D047BA649F95DAB60E5703EF9775@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703EF9775@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 07:23:32PM -0500, Moore, Eric Dean wrote:
> Please try the attached patch.
> Apply against the 2.6.3 kernel, which
> comes with mpt fusion 3.00.02 driver.
> 
> I expect the same results from mptbase, however
> mptscsih driver should load without the panic
> in mptscsih_init.  Please send dmesg if there
> still are issues.

Hi Eric,
 My failing Opteron system (IDE disk, no SCSI disk) now boots with your
2.6.3 Fusion patch in place.  My good Opteron system (SCSI disk, no IDE
disk) also continues to boot with this patch in place.

Thanks!
Joe

PS: Although booting, the boot messages from the once-failing system
indicate some rather unnerving failures.  Should I be concerned?


Fusion MPT base driver 3.00.04
Copyright (c) 1999-2003 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
mptbase: ioc0: ERROR - Doorbell ACK timeout(2)!
mptbase: ioc0: ERROR - Diagnostic reset FAILED! (102h)
mptbase: ioc0 NOT READY WARNING!
mptbase: WARNING - ioc0 did not initialize properly! (-1)
mptbase: probe of 0000:02:0a.0 failed with error -1
mptbase: Initiating ioc0 bringup
mptbase: ioc0: ERROR - Doorbell ACK timeout(2)!
mptbase: ioc0: ERROR - Diagnostic reset FAILED! (102h)
mptbase: ioc0 NOT READY WARNING!
mptbase: WARNING - ioc0 did not initialize properly! (-1)
mptbase: probe of 0000:02:0a.1 failed with error -1
Fusion MPT SCSI Host driver 3.00.04
