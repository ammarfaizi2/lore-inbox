Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVKPTFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVKPTFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVKPTFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:05:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:16063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750874AbVKPTFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:05:35 -0500
Date: Wed, 16 Nov 2005 10:50:12 -0800
From: Greg KH <greg@kroah.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel crash report in SCSI over USB with kernel 2.6.14
Message-ID: <20051116185012.GA7857@kroah.com>
References: <05GFF0511@briare1.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05GFF0511@briare1.heliogroup.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 08:45:41AM +0000, Hubert Tonneau wrote:
> This is stock Linux 2.6.14, SMP, with 6 USB disks and no real SCSI hardware.

USB storage is "real scsi" :)

> The kernel stack crash report is:
> scsi_end_request +0xaf/0xc0 [scsi_mod]
> scsi_io_completion
> scsi_finish_commands
> scsi_softirg
> __rcu_process_callblacks
> ksoftirqd
> ksoftirqd
> kthread
> kthread
> kernel_thread_helper

Care to file a bug at bugzilla.kernel.org with the full oops report in
it?

thanks,

greg k-h
