Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVEESAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVEESAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVEESAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:00:23 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27029 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262163AbVEESAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:00:18 -0400
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050505163316.GB17861@animx.eu.org>
References: <20050505004854.GA16550@animx.eu.org>
	 <58cb370e050505031041c2c164@mail.gmail.com>
	 <20050505111324.GA17223@animx.eu.org>
	 <58cb370e050505051360d0588c@mail.gmail.com>
	 <1115304977.23360.83.camel@localhost.localdomain>
	 <20050505153807.GB17724@animx.eu.org>
	 <1115310081.19842.89.camel@localhost.localdomain>
	 <20050505163316.GB17861@animx.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115315925.19842.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 May 2005 18:58:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-05-05 at 17:33, Wakko Warner wrote:
> Now, i have programs that I can't tell it the geometry (which it does use
> and requires to be correct.  My guesses using edd are correct).  I was using
> /proc/ide/hdX/settings to tell the kernel what geometry I want so the
> programs that can only ask the kernel can get it right.

And the geometry ioctls are obsolete for the applications too.

> If the "right" way is via IOCTL, my scripts are written in perl that do the
> bulk of the guess work.

I suspect it is for other programs that are still using that geometry
data and
really mkdosfs is what needs fixing ?

