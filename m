Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUI2NHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUI2NHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUI2NHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:07:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:59785 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268383AbUI2NHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:07:15 -0400
Subject: Re: [Patch] Fix oops on rmmod usb-storage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <415A67B8.2080003@suse.de>
References: <415A67B8.2080003@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096459477.15905.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 13:04:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 08:43, Hannes Reinecke wrote:
> Hi all,
> 
> I managed to (hopefully) fix an kernel Oops on rmmod usb-storage.
> The Oops we got was something like:

This is the same oops I see if I rmmod a scsi driver during error
handling. I'll give this patch a try

Thanks a lot

Alan

