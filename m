Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVC1PX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVC1PX1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVC1PX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:23:26 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:45520 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261865AbVC1PWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:22:52 -0500
Subject: Re: [2.6 patch] SCSI: cleanups
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050327202139.GQ4285@stusta.de>
References: <20050327202139.GQ4285@stusta.de>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 09:21:45 -0600
Message-Id: <1112023305.5531.2.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 22:21 +0200, Adrian Bunk wrote:
> This patch contains the following cleanups:
[..]

No to all of this:

> - remove the following unused functions:
>   - scsi.h: print_driverbyte
>   - scsi.h: print_hostbyte
> - #if 0 the following unused functions:
>   - constants.c: scsi_print_hostbyte
>   - constants.c: scsi_print_driverbyte

These are useful to those of us who debug drivers.

> - remove the following unneeded EXPORT_SYMBOL's:
>   - hosts.c: scsi_host_lookup
>   - scsi.c: scsi_device_cancel
>   - scsi_lib.c: scsi_device_resume

These are part of the SCSI API.

James


