Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVAYQdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVAYQdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVAYQdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:33:00 -0500
Received: from moutng.kundenserver.de ([212.227.126.191]:13284 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262011AbVAYQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:32:47 -0500
From: Elias da Silva <silva@aurigatec.de>
Organization: aurigatec Informationssysteme GmbH
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Date: Tue, 25 Jan 2005 17:28:56 +0100
User-Agent: KMail/1.7.2
References: <200501220327.38236.silva@aurigatec.de> <200501251713.27402.silva@aurigatec.de> <20050125162102.GS2751@suse.de>
In-Reply-To: <20050125162102.GS2751@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251728.57070.silva@aurigatec.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:71cf304d62c8802a383a5ddf42c5bd08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 17:21, you wrote:
: > : The command restriction table _only_ works through the SG_IO path, which
: > : does include CDROM_SEND_PACKET as well since it is layered on top of
: > : SG_IO. It doesn't control various driver ioctl exported interfaces, they
: > : would need to add a callback to verify_command() for permission checks.
: > 
: > Hmm... what exactly does that mean? Who is ment by "_they_ would need..."?
: 
: It refers back to 'various driver ioctl' earlier, so it refers to the
: driver itself.

Ouch... Jens, the various driver won't change by themselves!

Who is responsible, aka what is the name of the person(s)?
Are they reading this thread? Is this going to happen
(the driver changes) or is this only a wast of time?

Regards,

Elias
