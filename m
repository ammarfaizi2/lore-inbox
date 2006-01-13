Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422876AbWAMUG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422876AbWAMUG2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 15:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWAMUG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 15:06:28 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:18223 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422876AbWAMUG0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 15:06:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+zs59iebEU1TX+sjkZs+8huhkD8CvNHMpBO47bwKp5nyhXd2XSwE/L5+7a6EpcfIL3kOM3Wgum5uBk5tpVjvABzD2stbExAKdQwTfKAH0E3q0lR/jwTcIyWOgQjNp+VTZpieE2s4k+Slqd2zHYyYNtp+drsTfN4FbvHO3UnPJI=
Message-ID: <58cb370e0601131206u2507f8fewba34336c556ea61b@mail.gmail.com>
Date: Fri, 13 Jan 2006 21:06:24 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Greg K-H <greg@kroah.com>
Subject: Re: [PATCH] Add ide_bus_type probe and remove methods
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
In-Reply-To: <11371818123046@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11371818112032@kroah.com> <11371818123046@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please fix ide-scsi.c (should be trivial)

On 1/13/06, Greg KH <gregkh@suse.de> wrote:
> [PATCH] Add ide_bus_type probe and remove methods
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> ---
> commit 4031bbe4bbec6c0fe50412ef7fb43a270b0f29f1
> tree 1e1449ba492ab04d8c5fbc75f9761be237bcae72
> parent bbbe3a41f7ee529f7f4fdcc1bc1157234bac0766
> author Russell King <rmk@arm.linux.org.uk> Fri, 06 Jan 2006 11:41:00 +0000
> committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:10 -0800
>
>  drivers/ide/ide-cd.c     |   14 +++++---------
>  drivers/ide/ide-disk.c   |   22 ++++++++--------------
>  drivers/ide/ide-floppy.c |   14 +++++---------
>  drivers/ide/ide-tape.c   |   18 +++++++-----------
>  drivers/ide/ide.c        |   31 +++++++++++++++++++++++++++++++
>  include/linux/ide.h      |    5 +++++
>  6 files changed, 61 insertions(+), 43 deletions(-)
