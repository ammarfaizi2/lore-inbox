Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUIALpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUIALpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUIALox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:44:53 -0400
Received: from the-village.bc.nu ([81.2.110.252]:59530 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266155AbUIALol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:44:41 -0400
Subject: Re: prevent hdd spin-down at system halt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dirk Jagdmann <jagdmann@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5d0f6099040901030137a7f641@mail.gmail.com>
References: <5d0f609904083107571d78a41@mail.gmail.com>
	 <5d0f6099040901030137a7f641@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094035338.2399.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 11:42:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 11:01, Dirk Jagdmann wrote:
> is it possible to disable the spin-down (or powerdown) of hard disks
> when halting the system, via the kernel cmd-line or some
> configurations in /proc?

If someone provides the shutdown infrastructure to determine the
difference between shutdown/poweroff/return-to-firmware its easy. IDE
already has an ifdef to handle this on Alpha SRM because the higher
levels don't provide the ideal information.

