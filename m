Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTI3LFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 07:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbTI3LFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 07:05:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23501 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261337AbTI3LFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 07:05:18 -0400
Date: Tue, 30 Sep 2003 13:05:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-ID: <20030930110516.GK2908@suse.de>
References: <200309301028.h8UASdTI004280@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309301028.h8UASdTI004280@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30 2003, Joerg Schilling wrote:
> A year after I did report this inconsistency, it is still not fixed
> 
> If include/scsi/scsi.h is included without __KERNEL__ #defined, then this
> error message apears.
> 
> /usr/src/linux/include/scsi/scsi.h:172: parse error before "u8"
> /usr/src/linux/include/scsi/scsi.h:172: warning: no semicolon at end of struct 
> or union
> /usr/src/linux/include/scsi/scsi.h:173: warning: data definition has no type or 
> storage class
> 
> Is there no interest in user applications for kernel features or is there just
> no kernel maintainer left over who makes the needed work?

/usr/include/scsi/scsi.h looks fine on my system, probably also on
yours. You should not include kernel headers in your user space program.

-- 
Jens Axboe

