Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbSIPOqQ>; Mon, 16 Sep 2002 10:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262246AbSIPOqQ>; Mon, 16 Sep 2002 10:46:16 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:6640 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262177AbSIPOqP>; Mon, 16 Sep 2002 10:46:15 -0400
Subject: Re: Hi is this critical??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: louie miranda <louie@chikka.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006301c25d85$5bfcc180$0b00000a@nocpc3>
References: <20020916160536.1482173e.raptor@tvskat.net> 
	<006301c25d85$5bfcc180$0b00000a@nocpc3>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 16 Sep 2002 15:53:38 +0100
Message-Id: <1032188018.1191.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-16 at 14:31, louie miranda wrote:
> Is this critical??
> I have this error's over my kern.log file and when i type dmesg..
> Whats this all about? HD problems or some kernel conflict?
> 
> 
> --
> dmesg
> db: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: dma_intr: error=0x40 { UncorrectableError }, LBAsect=14912550,
> sector=10719504
> end_request: I/O error, dev 03:42 (hdb), sector 10719504

Your drive thinks it has a bad block. While your kernel is full of logs
showing pre-empt usage and breakage its very very improbable that such
an error would occur any other way but a genuine error report by the
drive

