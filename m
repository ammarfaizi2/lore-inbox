Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTL2E52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 23:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTL2E52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 23:57:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262705AbTL2E51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 23:57:27 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200312290457.hBT4vJFj006089@devserv.devel.redhat.com>
To: wrlk@riede.org
cc: linux-kernel@vger.kernel.org
Subject: Re: The survival of ide-scsi in 2.6.x
In-Reply-To: <mailman.1072462764.22951.linux-kernel2news@redhat.com>
References: <mailman.1072462764.22951.linux-kernel2news@redhat.com>
Date: Sun, 28 Dec 2003 23:57:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need ide-scsi to survive. Why? I maintain osst, a driver for
> OnStream tape drives, which need special handling. These drives
> exist in SCSI, ATAPI, USB and IEEE1394 versions.

> One high-level driver, osst, handles all of them, and that's how
> it should be, right? For ATAPI, it relies on ide-scsi.
> 
> (By the way, ide-tape contains code for the ATAPI version, the 
> DI-30, but that code is old and has serveral known problems - 
> I'd like to see it removed - or at least deprecated - I will do 
> that myself later if people want me to.)

Based on my expirience with ide-tape, I would rather have it
killed instead. One neat trick to appease enemies of ide-scsi
might be to rename it into ide-scsi into ide-tape-bis.
Might even add DSC bit handling... But the ide-tape is too
ugly to live for sure.

-- Pete
