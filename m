Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313163AbSDOSjl>; Mon, 15 Apr 2002 14:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313165AbSDOSjj>; Mon, 15 Apr 2002 14:39:39 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:8197 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313163AbSDOSjg>; Mon, 15 Apr 2002 14:39:36 -0400
Date: Mon, 15 Apr 2002 11:39:14 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH]
Message-ID: <Pine.LNX.4.10.10204151119350.1699-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.linuxdiskcert.org/ide-2.4.19-p6.all.convert.3.patch.bz2

Spinlock issues address and 99% fixed.
6 new chipsets.
Taskfile IO should be stable.
Borrowed cleanups from 2.5.5 credit given to <martin d>
Bunches of patchs that have been submitted but not added until now.

Thanks for all the support gang ... this should make life a little better.

AEC6280 U100
AEC6880 U133
SI680 U133
CSB6 U100
HPT374 U100(U133??)
HPT372
Intel ICH3
VIA latest (via vojtech)

Super Taskfile special vender modes, and transparent to API.

Things which can not be fixed yet.

Spinlock sleep during probe to get.
Spinlock on pci-proc operations.

Process to convert codebase to as single filter/mask ruleset for timings.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


