Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbSLFWey>; Fri, 6 Dec 2002 17:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267630AbSLFWey>; Fri, 6 Dec 2002 17:34:54 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:39343 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267638AbSLFWey>; Fri, 6 Dec 2002 17:34:54 -0500
Subject: Re: [2.5.50] IDE error messages appearing after upgrade
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <10525789281.20021206212219@uni.de>
References: <10525789281.20021206212219@uni.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 23:17:56 +0000
Message-Id: <1039216676.22983.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 20:22, Tobias Rittweiler wrote:
> Dec  6 21:00:23 brood kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Dec  6 21:00:23 brood kernel: hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> Dec  6 21:00:23 brood kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }

These are ok - its trying to set options the drive doesnt support and we
dont yet do that quietly.


