Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271065AbUJUWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271065AbUJUWlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271038AbUJUWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:40:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3806 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S271026AbUJUWf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:35:29 -0400
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE
	CF adaptor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <58cb370e041021121317083a3a@mail.gmail.com>
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098394354.17096.174.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 22:32:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 20:13, Bartlomiej Zolnierkiewicz wrote:
> ide_unregister() calls are not allowed unless somebody fixes locking
> (Alan fixed many issues but some more work is still needed)

>From review I think I've got them all fixed in 2.6, but yes 2.4 is a
bit of a lost cause there (although ide-cs works generally so its no big
barrier)

