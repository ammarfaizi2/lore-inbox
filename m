Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbTJCOzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 10:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTJCOzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 10:55:20 -0400
Received: from havoc.gtf.org ([63.247.75.124]:54404 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263735AbTJCOzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 10:55:18 -0400
Date: Fri, 3 Oct 2003 10:55:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Aniket Malatpure <aniket@sgi.com>, akmp@osdl.org, gwh@sgi.com,
       jeremy@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to add support for SGI's IOC4 chipset
Message-ID: <20031003145518.GA20625@gtf.org>
References: <3F7CB4A9.3C1F1237@sgi.com> <200310031645.57341.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310031645.57341.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 04:45:57PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Most of this declarations are not needed as sgiioc4.h is only included from shiioc4.c.


I agree...   but if you look at other PCI IDE drivers like piix.c,
you see the same thing.  Maybe we should blame Alan...   ;-)

	Jeff



