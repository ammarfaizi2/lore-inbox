Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTLWWYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTLWWYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:24:18 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:31236 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263130AbTLWWYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:24:15 -0500
Subject: Re: DEVFS is very good compared to UDEV
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jari Soderholm <Jari.Soderholm@edu.stadia.fi>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <sfe8cdc2.027@mail2.edu.stadia.fi>
References: <sfe8cdc2.027@mail2.edu.stadia.fi>
Content-Type: text/plain
Message-Id: <1072218249.5813.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 23 Dec 2003 23:24:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 22:20, Jari Soderholm wrote:
> Why could you develop it so that UDEV could create those
> actual device files there also, then most linux
> users would not need those horrible scipts anymore.
> All that is then needed link from /sysfs to /dev dir.

Well, udev way of doing things is very similar to Solaris. While booting
with -r, or by creating /.reconfigure, Solaris kernel scans the hardware
and creates entries in /devices tree. The /dev entries are just symlinks
to /devices entries.


