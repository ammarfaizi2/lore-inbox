Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132697AbRDOQdf>; Sun, 15 Apr 2001 12:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132696AbRDOQdZ>; Sun, 15 Apr 2001 12:33:25 -0400
Received: from quechua.inka.de ([212.227.14.2]:17512 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132697AbRDOQdK>;
	Sun, 15 Apr 2001 12:33:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI tape corruption problem
In-Reply-To: <200104140823.KAA30162@vulcan.alphanet.ch>
Date: Sun, 15 Apr 2001 15:04:31 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14omCe-0003m1-00@hunte.bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    tar cvf - . | gzip -9 | dd of=/dev/tapes/tape0 bs=32k

I have a tool which compresses individual files in a tar archive
instead of the whole archive[1]. That one tries hard to write only in
standard 10kb blocks to emulate tar's behavior towards the drive.
I'll try in a few days (when I'm back from holidays) if I have this
error on my scsi tape too (bad) and if the compression program affects
it.

Olaf

[1] <URL:http://sites.inka.de/bigred/sw/tarmill-0.22.tar.gz>

