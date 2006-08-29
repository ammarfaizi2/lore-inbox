Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWH2Kq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWH2Kq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWH2Kq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:46:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59833 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932267AbWH2Kqz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:46:55 -0400
Subject: Re: Can't enable DMA over ATA on Intel Chipset 2.6.16
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gustavo Guillermo =?ISO-8859-1?Q?P=E9rez?= 
	<gustavo@compunauta.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200608282042.26594.gustavo@compunauta.com>
References: <200608271239.32507.gustavo@compunauta.com>
	 <200608271434.35840.gustavo@compunauta.com>
	 <20060828195709.GL13641@csclub.uwaterloo.ca>
	 <200608282042.26594.gustavo@compunauta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Tue, 29 Aug 2006 12:04:47 +0100
Message-Id: <1156849487.6271.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-28 am 20:42 -0500, ysgrifennodd Gustavo Guillermo Pérez:
> an initrd with insmod loading firs scsi subsystem and piix before 
> ide-generic... Ok I can do that, but imagine, making a kernel for a 
> distribution, ;)

The generic IDE driver by default only attaches to known chipsets. This
isn't therefore a problem unless you specifically ask it to grab
everything.


