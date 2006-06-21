Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWFUPzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWFUPzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWFUPzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:55:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28612 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751174AbWFUPzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:55:16 -0400
Subject: Re: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver
	for PDC202XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Erik@echohome.org, linux-kernel@vger.kernel.org
In-Reply-To: <170fa0d20606210820l5a41150bs7e8a088d85ca8d3b@mail.gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
	 <1150887073.15275.34.camel@localhost.localdomain>
	 <23064.216.68.248.2.1150895349.squirrel@www.echohome.org>
	 <1150896840.15275.62.camel@localhost.localdomain>
	 <170fa0d20606210634t1ee3d186gd638feefd64d247d@mail.gmail.com>
	 <1150898829.15275.69.camel@localhost.localdomain>
	 <170fa0d20606210820l5a41150bs7e8a088d85ca8d3b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 17:10:36 +0100
Message-Id: <1150906236.15275.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 11:20 -0400, ysgrifennodd Mike Snitzer:
> ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata1: status=0x51 { DriveReady SeekComplete Error }
> ata1: error=0x84 { DriveStatusError BadCRC }

Thats a speed mistune somewhere in the code. 

Can you send me an lspci -vxx and the information on the drive (or
dmesg) with a "normal" kernel boot and I'll hunt it down.


Alan

