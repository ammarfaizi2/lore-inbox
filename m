Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbUL0UMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbUL0UMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUL0UMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:12:39 -0500
Received: from sweep.bur.st ([202.61.227.58]:5653 "EHLO stutter.bur.st")
	by vger.kernel.org with ESMTP id S261958AbUL0UKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:10:17 -0500
Date: Tue, 28 Dec 2004 04:10:15 +0800
From: Trent Lloyd <lathiat@bur.st>
To: William Park <opengeometry@yahoo.ca>, linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041227201015.GB18911@sweep.bur.st>
References: <20041227195645.GA2282@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227195645.GA2282@node1.opengeometry.net>
X-Random-Number: 9.81640062318437e+302
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is really suited to the task of an initrd, then you can spin until
the usb storage device comes up in a bash script or something similar.

Cheers,
Trent

> How do I make the kernel to wait about 10s before attempting to mount
> root filesystem?  Is there obscure kernel parameter?
> 
> I can load the kernel from /dev/fd0, then mount /dev/hda2 as root
> filesystem.  But, I can't seem to mount /dev/sda1 (USB key drive) as
> root filesystem.  All relevant USB and SCSI modules are compiled into
> the kernel.  I think kernel is too fast in panicking.  I would like the
> kernel to wait about 10s until 'usb-storage' and 'sd_mod' work out all
> the details.
> 
> -- 
> William Park <opengeometry@yahoo.ca>
> Open Geometry Consulting, Toronto, Canada
> Linux solution for data processing. 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
