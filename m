Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWANUcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWANUcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWANUcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:32:39 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:32007 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751084AbWANUcj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:32:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FAQ6HVMTC9lGHjEJJTCDk9OpCnkiJHu4DjveIFzWlMXmMqGOxSi3f1iS3fgds0RHA0PuP1fX6xHjPM+QI8hOb6bQuxz6qr7wItUyqDbNcxLq7/ygoTCvHbYIi/S4H79swXp3S014X6gN7Yl7IJickdUBEHjBcZMiOAVgdCRfv2Q=
Message-ID: <58cb370e0601141232y110e7876ide98d9ed1213285c@mail.gmail.com>
Date: Sat, 14 Jan 2006 21:32:37 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Greg K-H <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add ide_bus_type probe and remove methods
In-Reply-To: <20060114195753.GC24816@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11371818112032@kroah.com> <11371818123046@kroah.com>
	 <58cb370e0601131206u2507f8fewba34336c556ea61b@mail.gmail.com>
	 <20060114195753.GC24816@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Fri, Jan 13, 2006 at 09:06:24PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > please fix ide-scsi.c (should be trivial)
>
> Updated patch attached.  However, unable to even build-test since ide-scsi
> is already broken:
>
> drivers/scsi/ide-scsi.c: In function `idescsi_eh_reset':
> drivers/scsi/ide-scsi.c:1046: error: too few arguments to function `end_that_request_last'
> drivers/scsi/ide-scsi.c:1056: error: too few arguments to function `end_that_request_last'

Thanks, I will look into this.
