Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTJFHwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 03:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTJFHwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 03:52:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64411 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262785AbTJFHwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 03:52:38 -0400
Date: Mon, 6 Oct 2003 09:52:19 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: andersen@codepoet.org, Philippe Lochon <plochon.n0spam@free.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility ?
Message-ID: <20031006075219.GX966@suse.de>
References: <3F7EDCDD.7090500@free.fr> <20031004180338.GA24607@codepoet.org> <20031004192733.GA30371@gtf.org> <20031004195342.GA25328@codepoet.org> <20031005201638.GB4259@codepoet.org> <3F80B68D.8090109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F80B68D.8090109@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05 2003, Jeff Garzik wrote:
> As a tangent, I wonder if the latest cdrecord works in 2.4 with 
> 'dev=/dev/hdc' ... that would elimiante the need for ide-scsi.

It probably does, but through the CDROM_SEND_PACKET ioctl which doesn't
work very well. It is in no way a suitable replacement for ide-scsi, so
I'm afraid this plan wont fly at all.

-- 
Jens Axboe

