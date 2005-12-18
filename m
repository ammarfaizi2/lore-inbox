Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965294AbVLRWYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbVLRWYc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbVLRWYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:24:32 -0500
Received: from ns1.heckrath.net ([213.239.205.18]:62856 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S965294AbVLRWYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:24:31 -0500
Date: Sun, 18 Dec 2005 23:24:28 +0100
From: Sebastian Kaergel <mailing@wodkahexe.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: mailing@wodkahexe.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: Linux 2.6.14.4 [intelfb problem]
Message-Id: <20051218232428.01d5f315.mailing@wodkahexe.de>
In-Reply-To: <43A5D963.9020201@gmail.com>
References: <20051215005041.GB4148@kroah.com>
	<20051218204253.b32a4f61.mailing@wodkahexe.de>
	<43A5D963.9020201@gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
> Sometimes, this is just a problem with the bootloader not recognizing
> the option parameters.
> 
> > image=/boot/2.6.14.4-3
> >  append="video=intelfb"
> 
> 'cat /proc/cmdline' should confirm if your options where actually passed
> unchanged to the kernel.

 $ cat /proc/cmdline 
BOOT_IMAGE=2.6.14.4 ro root=301 lapic video=intelfb

cmdline looks fine
