Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270399AbTGRXnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 19:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270414AbTGRXnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 19:43:00 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:34773 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270399AbTGRXm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 19:42:59 -0400
Subject: RE: Partitioned loop device..
From: Christophe Saout <christophe@saout.de>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>,
       Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0307181508490.11351@filesrv1.baby-dragons.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3840AB@frodo.avalon.ru>
	 <1058538027.19986.3.camel@chtephan.cs.pocnet.net>
	 <Pine.LNX.4.56.0307181508490.11351@filesrv1.baby-dragons.com>
Content-Type: text/plain
Message-Id: <1058572673.3825.4.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 01:57:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, 2003-07-18 um 21.10 schrieb Mr. James W. Laferriere:

> Hello Christophe ,  Are the tools you use in this script only for
> 2.5/2.6 ?  Tia ,  JimL

It uses dmsetup, so it needs the device-mapper. The device-mapper is
integrated into the 2.5/2.6 kernel, but also exists as a patch to the
2.4 kernel (you would probably need to patch the kernel anyway).

You probably want this kernel patch (against 2.4.21):
ftp://ftp.sistina.com/pub/LVM2/device-mapper/patches-version4/combined-linux-2.4.21-devmapper-ioctl.patch

And then compile the dmsetup tool:
ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper.1.00.02.tgz

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

