Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUXg2>; Wed, 21 Feb 2001 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRBUXgS>; Wed, 21 Feb 2001 18:36:18 -0500
Received: from anime.net ([63.172.78.150]:49418 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129181AbRBUXgI>;
	Wed, 21 Feb 2001 18:36:08 -0500
Date: Wed, 21 Feb 2001 15:36:08 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: "Michael B. Allen" <mballen@erols.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.17 Lockup and ATA-66/100 forced bit set (WARNING)
In-Reply-To: <20010221173439.A3178@angus.foo.net>
Message-ID: <Pine.LNX.4.30.0102211534420.11979-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Michael B. Allen wrote:
> And why do I have 8 cdroms?
> kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> kernel: scsi : 1 host.
> kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  Rev: 1.07
> kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02

It's an old old bug with the ide-scsi lun probing code. Dont know if 2.4.x
fixed it yet. Solution -- disable lun probing in scsi config.

-Dan

