Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbUK3T7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUK3T7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUK3T4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:56:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262301AbUK3Txy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:53:54 -0500
Subject: Re: Walking all the physical memory in an x86 system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0411301832510.11795@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406>
	 <Pine.LNX.4.53.0411301711140.25731@yvahk01.tjqt.qr>
	 <41ACADD3.2030206@draigBrady.com>
	 <Pine.LNX.4.53.0411301832510.11795@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101840619.25609.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:50:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 17:34, Jan Engelhardt wrote:
> 	unsigned short p;
> 	fd = open("/dev/mem", O_RDONLY | O_BINARY);
> 	lseek(fd, 0x400, SEEK_SET);
> 	read(fd, &p, 2);

You want ports for that not mem, has always been the case since back
before Linux existed.

