Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVEEQXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVEEQXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVEEQXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:23:32 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10901 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262150AbVEEQXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:23:13 -0400
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050505153807.GB17724@animx.eu.org>
References: <20050505004854.GA16550@animx.eu.org>
	 <58cb370e050505031041c2c164@mail.gmail.com>
	 <20050505111324.GA17223@animx.eu.org>
	 <58cb370e050505051360d0588c@mail.gmail.com>
	 <1115304977.23360.83.camel@localhost.localdomain>
	 <20050505153807.GB17724@animx.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115310081.19842.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 May 2005 17:21:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As stated in my last email, I am using EDD.  I only need the legacy heads
> and sectors.  I can figure out the cylinders by that and the size of the
> disk.

Which legacy size do you want though - the partition label, the disks
opinion this week or the CMOS. They can all be different. Linux used to
play "guess roughly what Windows might guess".

> I have some utils (mkdosfs comes to mind) that do not let the user specify
> heads/sectors/cyls (it doesn't use cyl actually).

Presumably they need to follow the MS sequence of guesses then, even on
non PC systems ? So partition table, cmos, drive in that order if I
remember rightly.

