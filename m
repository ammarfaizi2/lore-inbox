Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWBLB74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWBLB74 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 20:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBLB74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 20:59:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10974 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932178AbWBLB74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 20:59:56 -0500
Subject: Re: NCR 53c700-66 MCA(EISA) doesn't want to work(2.4.x)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zdenek Styblik <stybla@turnovfree.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43EE5D68.5080501@turnovfree.net>
References: <43EE5D68.5080501@turnovfree.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Feb 2006 02:02:15 +0000
Message-Id: <1139709735.23823.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-02-11 at 22:55 +0100, Zdenek Styblik wrote:
> I have Intel Professional Workstation with LP468 motherboard which has
> everything else except PCI. There is integrated SCSI controller NCR
> 53c700-66 50pin which is probably on MCA(or EISA bus). Problem is that
> I can't make it work. I tried NCR 53c7xx, 8xx support(naturally), but

I had an old panther board years and years ago although it blew up in
the end and which is similar. I always used the IDE on it.

There is an NCR53C700 core driver in the SCSI layer and MCA drivers for
a couple of boards but at minimum I suspect you are looking at writing a
new board interface assuming you can get enough information to do so.

