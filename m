Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTLVWHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTLVWHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:07:08 -0500
Received: from [217.73.129.129] ([217.73.129.129]:60367 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264527AbTLVWHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:07:05 -0500
Date: Tue, 23 Dec 2003 00:05:57 +0200
Message-Id: <200312222205.hBMM5vLv012067@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Ooops with kernel 2.4.22 and reiserfs
To: devel@integra-sc.it, linux-kernel@vger.kernel.org
References: <1072126808.21200.3.camel@atena>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Carlo <devel@integra-sc.it> wrote:
C> i receive the follow message error when i delete file from a large
C> partition (100GB) of an IDE drive (120GB) with reiserfs filesystem and
C> kernel 2.4.22. Other partitions are EXT3.
C> I received this message several time in my test that erase jpeg files in
C> nested directories.

C> hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete
C> DataRequest }
C> ide0: Drive 0 didn't accept speed setting. Oh, well.
C> hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
C> hda: CHECK for good STATUS

Do you always get these IDE errors prior to oops?

C> Unable to handle kernel paging request at virtual address ffffffe0
C>  printing eip:
C> EIP:    0010:[<c0146553>]    Not tainted
C> cded5e40
C> Call Trace:    [<c01465dd>] [<c013fa0f>] [<c018d840>] [<c013fb69>]
C> [<c013fc84>]
C>   [<c0114d00>] [<c01088a3>]

Also please run your oops through ksymoops.

Bye,
    Oleg
