Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbULVXXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbULVXXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbULVXXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:23:37 -0500
Received: from av5-2-sn3.vrr.skanova.net ([81.228.9.114]:36238 "EHLO
	av5-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262081AbULVXXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:23:35 -0500
To: Vince <fuzzy77@free.fr>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: cannot eject drive using pktcdvd
References: <41BF6935.3040300@free.fr>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Dec 2004 00:04:59 +0100
In-Reply-To: <41BF6935.3040300@free.fr>
Message-ID: <m3hdmeue78.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vince <fuzzy77@free.fr> writes:

> I see the following bug since I've enabled packet writing for my dvd
> drive (using the udftools package):
> 
> - eject won't open the tray unless I'm root
> 
> - whether I'm root or not, I get the following error when running eject:
>      "eject: unable to eject, last error: Invalid argument"
>    and in the system logs:
> "program eject is using a deprecated SCSI ioctl, please convert it to SG_IO"
> 
> The command: pktsetup dvd /dev/cdrom ; eject
> should allow anyone with a cd/dvd writer to reproduce this bug.
> 
> Disabling packet writing ("pktsetup -d dvd") solves the problem and
> everything works fine (no strange message in the logs).

I can't reproduce any of these problems on my laptop. I run FC3 and
kernel 2.6.10-rc3-bk6. I tried both with a USB CDRW drive and an IDE
DVD+RW drive.

More info is needed. What distribution? What kernel? And please
provide strace logs from eject when it fails.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
