Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTFJQOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTFJQOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:14:17 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:3277 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263365AbTFJQOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:14:16 -0400
Subject: Re: [PATCH] IDE Power Management, try 2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030610161503.GH17164@suse.de>
References: <1054820805.766.10.camel@gaston>
	 <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
	 <20030610161503.GH17164@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055262472.705.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jun 2003 18:27:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 18:15, Jens Axboe wrote:
> On Thu, Jun 05 2003, Bartlomiej Zolnierkiewicz wrote:
> > Jens, I think generic version of ide_do_drive_cmd() would be useful for
> > other block devices, what do you think?
> 
> Something ala this? Completely untested, and I only did scsi_ioctl.c and
> ide-io.c. iirc, scsi uses somthing similar that could be adapted too.

Hrm... you didn't keep some functionalities I added with the PM
patch here... like marking of preempt requests so I can fetch them
even when drive is blocked, and ide_head_wait...

Ben 
