Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVAYJdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVAYJdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 04:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVAYJdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 04:33:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:25025 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261758AbVAYJdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 04:33:08 -0500
From: Elias da Silva <silva@aurigatec.de>
Organization: aurigatec Informationssysteme GmbH
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Date: Tue, 25 Jan 2005 10:29:22 +0100
User-Agent: KMail/1.7.2
References: <200501220327.38236.silva@aurigatec.de> <200501242310.00184.silva@aurigatec.de> <1106611309.6148.116.camel@localhost.localdomain>
In-Reply-To: <1106611309.6148.116.camel@localhost.localdomain>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251029.22646.silva@aurigatec.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:71cf304d62c8802a383a5ddf42c5bd08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 01:01, you wrote:
[snip]
: > This is exactly the point: if the kernel wants to be safe, the
: > authentication procedure should be totally implemented in the kernel
: > and be protected against further changes via "alternative" ways...
: > but it isn't now and probably won't be although it could be.
: 
: It provides the DVD_AUTH ioctls to handle this. Why are you banging raw
: commands at hardware when there is an abstraction for it ?
Hello.

This is the way VMware and probably other comparable emulators
access the devices.

Yes, sometimes you have to risk broken software in favor of augmented
security, but so far we only have broken software.

: Someone did actually have a demo of a small fs that allowed you to
: fiddle with the status but possibly the code could get smarter for
: "exclusive user of media". I'm not sure if that is worth it.

Do you have the name of the fs and/or the name of author?

Do we have a clear understanding that this fs would only
be a benefit if *All* the different ways to access the device would
use the same policy enforcement and consistently allow or
disallow certain operations regardless of the access method?

Regards,

Elias
