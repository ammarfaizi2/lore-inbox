Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbTE0PIC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTE0PIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:08:02 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:39376
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263790AbTE0PIC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:08:02 -0400
Date: Tue, 27 May 2003 11:21:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030527152113.GA21744@gtf.org>
References: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com> <1054047595.1975.64.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054047595.1975.64.camel@mulgrave>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 10:59:51AM -0400, James Bottomley wrote:
> We're certainly not there yet, since we need to support legacy
> interfaces like /proc/scsi/scsi.  But eventually you'll probably see us
> using the sysfs name instead of the id (FC devices will probably stuff
> WWNs in here, other things may use numbers) and lun (not sure how we'll
> represent SCSI-3 LUN hierarchies yet).  Hopefully, it will be possible
> to make the mid layer entirely unaware of any id/lun distinction so it
> could be configured for a flatter host/device space instead.

ATA defines WWN too...  I'm curious what the format is?  uuid-ish?

	Jeff



