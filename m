Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272978AbTG3QbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272976AbTG3QbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:31:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53443 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S272973AbTG3QbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:31:03 -0400
Date: Wed, 30 Jul 2003 18:30:14 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Subject: [PATCH] Re: [TRIVIAL] kill surplus menu in IDE Kconfig
In-Reply-To: <20030730055725.GG4279@louise.pinerecords.com>
Message-ID: <Pine.SOL.4.30.0307301823210.8913-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003, Tomas Szepe wrote:

> > [B.Zolnierkiewicz@elka.pw.edu.pl]
>
> > - kill CONFIG_BLK_DEV_PDC202XX
>
> How do you mean?

It is not needed anymore.
We have now CONFIG_BLK_DEV_PDC202XX_OLD and CONFIG_BLK_DEV_PDC202XX_NEW.

> > Does it sound sane?  If so I will later post patches for you review.
>
> Sounds good.  I can generate these patches if you're interested.

Patches are at:
http://home.elka.pw.edu.pl/~bzolnier/ide-Kconfig/

They are against 2.6.0-test2.

--
Bartlomiej

