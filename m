Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267272AbUHSTNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267272AbUHSTNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUHSTNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:13:07 -0400
Received: from the-village.bc.nu ([81.2.110.252]:12677 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267272AbUHSTNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:13:04 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408191800.56581.bzolnier@elka.pw.edu.pl>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <200408191800.56581.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092938773.28350.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 19:06:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 17:00, Bartlomiej Zolnierkiewicz wrote:
> > As a security fix it was sufficiently important that it had to be done.
> 
> IMO work-rounding this in kernel is a bad idea and could break a lot of 
> existing apps (some you even don't know about).  Much better way to deal with 
> this is to create library for handling I/O commands submission and gradually 
> teach user-space apps to use it.

And what do you do the day someone posts "lock IDE drive with random
password as any user" to bugtraq ?

