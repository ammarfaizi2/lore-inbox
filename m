Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUGIUwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUGIUwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUGIUwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:52:15 -0400
Received: from [213.4.129.129] ([213.4.129.129]:41678 "EHLO tsmtp18.mail.isp")
	by vger.kernel.org with ESMTP id S264629AbUGIUwM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:52:12 -0400
Date: Fri, 9 Jul 2004 22:44:00 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Stefan Reinauer <stepan@openbios.org>
Cc: hch@infradead.org, pavel@suse.cz, erik@rigtorp.com,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-Id: <20040709224400.4f44303a.diegocg@teleline.es>
In-Reply-To: <20040709144859.GA18243@openbios.org>
References: <20040708110549.GB9919@linux.nu>
	<20040708133934.GA10997@infradead.org>
	<20040708204840.GB607@openzaurus.ucw.cz>
	<20040708210403.GA18049@infradead.org>
	<20040709144859.GA18243@openbios.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 9 Jul 2004 16:48:59 +0200 Stefan Reinauer <stepan@openbios.org> escribió:

> Whether one wants retro text messages or a graphical bootup mechanism is
> sure a philosophical thing. IMHO starting X that early is not an option.

Is really neccesary to use a X server? Why not just modify the init scripts to
use fbi to show a image? Is not that the kernel takes a lot of time to boot and
run init - even windows XP shows an ascii bar while it loads their kernel,
that period of time doesn't takes too much time and it doesn't annoy anyone.
You could switch off the printk output too, so the users doesn't see any
kernel message at all while init runs and the scripts puts the image in the
framebuffer console.
