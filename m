Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265361AbUGIVuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbUGIVuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUGIVuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 17:50:08 -0400
Received: from [193.12.224.70] ([193.12.224.70]:23519 "EHLO defiant")
	by vger.kernel.org with ESMTP id S265361AbUGIVuF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 17:50:05 -0400
Date: Fri, 9 Jul 2004 23:49:40 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Diego Calleja =?iso-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Stefan Reinauer <stepan@openbios.org>, hch@infradead.org, pavel@suse.cz,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040709214940.GA9176@linux.nu>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org> <20040709144859.GA18243@openbios.org> <20040709224400.4f44303a.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20040709224400.4f44303a.diegocg@teleline.es>
X-GPG-Key: Search for erkki@linux.nu at wwwkeys.eu.pgp.net
X-GPG-Fingerprint: 0534 CF05 8171 3EC6 921A  346F 1882 91C4 993F C709
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 10:44:00PM +0200, Diego Calleja García wrote:
> Is really neccesary to use a X server? Why not just modify the init scripts to
> use fbi to show a image? Is not that the kernel takes a lot of time to boot and
> run init - even windows XP shows an ascii bar while it loads their kernel,
So you know the internals of the NT kernel? That bar is probably just the
bootloader loading the kernel from disk :).

> that period of time doesn't takes too much time and it doesn't annoy anyone.
> You could switch off the printk output too, so the users doesn't see any
> kernel message at all while init runs and the scripts puts the image in the
> framebuffer console.
That is the "clean" approach, but what I wanted was something nice to look
at while booting or suspending my laptop. Whether it be a retro ascii thingy
or a fancy graphical thingy doesn't really matter. 
