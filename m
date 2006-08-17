Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWHQNlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWHQNlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWHQNlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:41:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:45741 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964977AbWHQNlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:41:13 -0400
Message-ID: <44E471F2.5000003@garzik.org>
Date: Thu, 17 Aug 2006 09:41:06 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de,
       Arjan van de Ven <arjan@infradead.org>, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it> <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz> <1155821951.15195.85.camel@localhost.localdomain> <20060817132309.GX13639@csclub.uwaterloo.ca>
In-Reply-To: <20060817132309.GX13639@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> Why can't O_EXCL mean that the kernel prevents anyone else from issuing
> ioctl's to the device?  One would think that is the meaning of exlusive.
> That way when the burning program opens the device with O_EXCL, no one
> else can screw it up while it is open.  If it happens to be polled by
> hal when the burning program tries to open it, it can just wait and
> retry again until it gets it open.

Such use of O_EXCL is a weird and non-standard behavior.

	Jeff


