Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268782AbRG0FoF>; Fri, 27 Jul 2001 01:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268783AbRG0Fnz>; Fri, 27 Jul 2001 01:43:55 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:33953 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S268782AbRG0Fns>; Fri, 27 Jul 2001 01:43:48 -0400
Date: Thu, 26 Jul 2001 22:42:58 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Hard disk problem:
In-Reply-To: <Pine.LNX.4.33.0107270005210.25463-100000@asdf.capslock.lan>
Message-ID: <Pine.GSO.4.10.10107262239100.23974-100000@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



I don't know my drives that well, but it looks like a drive problem to me.

> Is this a hardware or software problem, or could it be either?
> 
> Jul 26 23:51:59 asdf kernel: hda: dma_intr: status=0x51
> { DriveReady SeekComplete Error }

I believe that his means the drive failed to seek to the desired sector,
it was either miscalibrated, or the sector was bad.

> Jul 26 23:51:59 asdf kernel: hda: dma_intr: error=0x40
> { UncorrectableError }, LBAsect=8545004, sector=62608
> Jul 26 23:51:59 asdf kernel: end_request: I/O error, dev 03:05
> (hda), sector 62608

I believe that this means that even with the on disk ECC the data from
the sector was not recoverable.




-Kip

