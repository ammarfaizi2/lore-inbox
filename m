Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUKWRxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUKWRxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUKWRvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:51:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52398 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261418AbUKWRvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:51:03 -0500
Date: Tue, 23 Nov 2004 09:50:51 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Pasi Savolainen <psavo@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: k 2.6.9: ub module causes /dev/sda and /dev/sda1 not being
 created
Message-ID: <20041123095051.5bbcf77e@lembas.zaitcev.lan>
In-Reply-To: <mailman.1099132081.20925.linux-kernel2news@redhat.com>
References: <4182FA3D.1090108@esoterica.pt>
	<mailman.1099132081.20925.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004 10:23:28 +0000 (UTC), Pasi Savolainen <psavo@iki.fi> wrote:

> There is a notion that 125 -major number will be going away?:
> <https://lists.one-eyed-alien.net/pipermail/usb-storage/2004-August/000709.html>

Yes, it has to go. I have received number 180 from LANANA.

I am sorry for the delay. My original plan was to use dynamic majors,
but a few people wanted to use ub on systems with 2.6 kernels but without
hald or udev, so a static major was needed. In such a case, it has to be
non-conflicting.

-- Pete
