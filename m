Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUL1XHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUL1XHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUL1XHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:07:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17567 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261154AbUL1XHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:07:51 -0500
Subject: Re: PATCH: 2.6.10 - Still mishandles volumes without geometry data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e041228124878cb6e2a@mail.gmail.com>
References: <1104155840.20898.3.camel@localhost.localdomain>
	 <58cb370e041228124878cb6e2a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104271428.26109.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Dec 2004 22:03:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +
> >         /*
> Shouldn't this check be around printk in idedisk_setup() instead?

Yes that would be useful as well. I'll send you a new patch that catches
that printk as well.

