Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263754AbTJCPKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263755AbTJCPKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:10:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58850 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263754AbTJCPKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:10:03 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Date: Fri, 3 Oct 2003 17:13:23 +0200
User-Agent: KMail/1.5.4
Cc: Aniket Malatpure <aniket@sgi.com>, akmp@osdl.org, gwh@sgi.com,
       jeremy@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
References: <3F7CB4A9.3C1F1237@sgi.com> <200310031645.57341.bzolnier@elka.pw.edu.pl> <20031003145518.GA20625@gtf.org>
In-Reply-To: <20031003145518.GA20625@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310031713.24006.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 of October 2003 16:55, Jeff Garzik wrote:
> On Fri, Oct 03, 2003 at 04:45:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Most of this declarations are not needed as sgiioc4.h is only included
> > from shiioc4.c.
>
> I agree...   but if you look at other PCI IDE drivers like piix.c,
> you see the same thing.  Maybe we should blame Alan...   ;-)

Not exactly...
in piix.h you have only declarations which are later used in piix.h.

Maybe all these PCI IDE *.h files should die, I find them really
annoying while going through PCI IDE *.c files.

--bartlomiej

