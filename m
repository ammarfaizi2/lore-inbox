Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVAYQR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVAYQR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVAYQR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:17:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:6621 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261997AbVAYQRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:17:18 -0500
From: Elias da Silva <silva@aurigatec.de>
Organization: aurigatec Informationssysteme GmbH
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Date: Tue, 25 Jan 2005 17:13:27 +0100
User-Agent: KMail/1.7.2
References: <200501220327.38236.silva@aurigatec.de> <200501251029.22646.silva@aurigatec.de> <20050125124512.GM2751@suse.de>
In-Reply-To: <20050125124512.GM2751@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251713.27402.silva@aurigatec.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:71cf304d62c8802a383a5ddf42c5bd08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 13:45, you wrote:
[snip]
: If I'm not mistaken, Peter Jones has posted a few iterations of such an
: fs some months ago.

Thank you. I will check this...

: > Do we have a clear understanding that this fs would only
: > be a benefit if *All* the different ways to access the device would
: > use the same policy enforcement and consistently allow or
: > disallow certain operations regardless of the access method?
: 
: The command restriction table _only_ works through the SG_IO path, which
: does include CDROM_SEND_PACKET as well since it is layered on top of
: SG_IO. It doesn't control various driver ioctl exported interfaces, they
: would need to add a callback to verify_command() for permission checks.

Hmm... what exactly does that mean? Who is ment by "_they_ would need..."?

I don't want to take responsability for the reaction of the xine/mplayer/etc.
community the day their software stops playing video DVDs on Linux ;-)

Regards,

Elias
