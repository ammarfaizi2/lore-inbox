Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWGaKqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWGaKqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWGaKqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:46:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:458 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751292AbWGaKqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:46:47 -0400
Subject: Re: Fwd: PROBLEM: ide messages during boot caused by a strange
	partition table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: marco gaddoni <marco.gaddoni@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3b2bc9d0607302316s68734797r212e0a422ed26a50@mail.gmail.com>
References: <3b2bc9d0607302313p637ce780sf98b1727213bd6a2@mail.gmail.com>
	 <3b2bc9d0607302316s68734797r212e0a422ed26a50@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 12:05:47 +0100
Message-Id: <1154343947.7230.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-31 am 08:16 +0200, ysgrifennodd marco gaddoni:
> hda: task_in_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hda: task_in_intr: error=0x10 { SectorIdNotFound },
> LBAsect=1052835654, high=62, low=12648262, sector=1052835654

The sector number appears valid for the drive (assuming the drive
9733 255 63 geometry is correct), so that looks like a bad block on the
disk and nothing to do with partition tables.

