Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314526AbSDSDmu>; Thu, 18 Apr 2002 23:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314527AbSDSDmu>; Thu, 18 Apr 2002 23:42:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:2057 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314526AbSDSDmt>; Thu, 18 Apr 2002 23:42:49 -0400
Date: Thu, 18 Apr 2002 20:41:54 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] ide-2.4.19-p7.all.convert.5.patch
Message-ID: <Pine.LNX.4.10.10204182030140.17538-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.5.patch.bz2

This now has clean taskfile io tested on two archs.

Both PowerMac UP and x86 all appear stable with taskfile io enabled.
PPC well generate a random missed interrupt in mult-mode pio on a sync
call but it never misses a beat or hangs.

Feed back from a few people have stated Sparc ?? amnd PPC64 appear stable.

IA-64 is the only know broken arch.  Since returning the heater^WItanic^box 
testing various hardware there is not practical.

Cheers and Complain if it does not work.

Andre Hedrick
LAD Storage Consulting Group

