Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWAIOQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWAIOQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWAIOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:16:22 -0500
Received: from [81.2.110.250] ([81.2.110.250]:20714 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750986AbWAIOQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:16:21 -0500
Subject: Re: kernel BUG at drivers/ide/ide.c:1384!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060109095159.GE4535@charite.de>
References: <20060109095159.GE4535@charite.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 14:19:12 +0000
Message-Id: <1136816352.6659.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-09 at 10:51 +0100, Ralf Hildebrandt wrote:
> I invoked "hdparm -w /dev/hda"
> 
> # uname -a
> Linux hummus.charite.de 2.6.15 #1 Tue Jan 3 09:30:04 CET 2006 i686 GNU/Linux
> 
> Before you flame away at me for using the nvidia kernel module: I will
> reproduce this WITHOUT the nvidia kernel module. At least I'll try.

You should be able to reproduce it without the Nvidia code loaded if you
do I/O on the disk and run hdparm -w in a tight loop while doing so.

You might want to do it on a disk you have a backup of

