Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbUKRSoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbUKRSoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUKRSmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:42:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34245 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262863AbUKRSlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:41:12 -0500
Date: Thu, 18 Nov 2004 19:40:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: Missing SCSI command in the allowed list?
Message-ID: <20041118184039.GM26240@suse.de>
References: <cmikie$vif$1@sea.gmane.org> <200411061624.57918.dsd@gentoo.org> <cmkkd8$dm8$1@sea.gmane.org> <419CEC65.4020603@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419CEC65.4020603@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18 2004, Daniel Drake wrote:
> Hi,
> 
> Alexander E. Patrakov wrote:
> >But the question remains: what should the users of not 100% MMC-compatible
> >CR-RW drives (i.e. those which have a separate cdrado or cdrecord driver,
> >not generic-mmc/generic-mmc-raw) do? Is the support for writing as non-root
> >on such drives just dropped without any plans to "fix" it?
> 
> I'd also be interested to know the answer here. Jens?
> 
> Some Gentoo users have reported that commands such as ED/EB/E9/F5 are being 
> rejected. When inspecting the cdrecord source code, it seems that these are 
> specific to plextor drives. These drives are MMC but have a few 
> vendor-specific extensions. How should we go about permitting cases like 
> this in the command filter?

See Alans post, that's the only real way to deal with the situation.
Right now we are stuck with half a solution (which is better than none
or the 5% initial solution), it would still be nice to have it finished.
Search the archives, there were several posts on this.

-- 
Jens Axboe

