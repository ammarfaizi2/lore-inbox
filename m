Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267868AbUHPSif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267868AbUHPSif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267861AbUHPSif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:38:35 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7909 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266128AbUHPSib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:38:31 -0400
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <200408161923.19024.bzolnier@elka.pw.edu.pl>
References: <20040815151346.GA13761@devserv.devel.redhat.com>
	 <200408161923.19024.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092677759.21013.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 18:36:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 18:23, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 15 August 2004 17:13, Alan Cox wrote:
> > There really isnt any sane way to break this patch down because all the
> > changes are interlinked so closely.
> 
> at least /proc/ide/hd?/settings:ide-scsi removal and doc fixes are very easy 
> to separate, I also think that locking fixes should be separated from 
> hotplugging ones

I continue to believe splitting the locking and hotplugging ones are
essentially impossible without inventing a fake never written version.
The other stuff can probably be done.

If you can let me know which bits you are going to apply I can work on
sorting out the rest. In the meantime I'll keep a -ac patch for people
who want to work on the IDE bits or who need the fixes and driver
updates.

Alan

