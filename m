Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267764AbRGQEWS>; Tue, 17 Jul 2001 00:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbRGQEV7>; Tue, 17 Jul 2001 00:21:59 -0400
Received: from hs2-108.magma.ca ([64.26.169.108]:7570 "EHLO
	mokona.furryterror.org") by vger.kernel.org with ESMTP
	id <S267761AbRGQEVt>; Tue, 17 Jul 2001 00:21:49 -0400
From: uixjjji1@umail.furryterror.org (Zygo Blaxell)
Subject: Promise FastTrack 100 TX2 PCI device ID's
Date: 17 Jul 2001 00:20:13 -0400
Organization: A poorly-maintained Debian GNU/Linux InterNetNews site
Message-ID: <9j0edt$t7q$1@sana.furryterror.org>
NNTP-Posting-Host: 10.250.7.77
X-Header-Mangling: Original "From:" was <zblaxell@sana.furryterror.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed a shiny new Promise FastTrack 100 TX2.  'lspci -n'
shows this (among other things):

	00:0a.0 RAID bus controller: Promise Technology, Inc.: Unknown device 6268 (rev 01)

The latest IDE patches (2.4.6) on top of Linux 2.4.6 I can find say this:

	#define PCI_DEVICE_ID_PROMISE_20268     0x4d68

Needless to say, the kernel fails to see my Promise card.

If I change the #define to

	#define PCI_DEVICE_ID_PROMISE_20268     0x6268

everything seems to work:  the Promise card is detected and seems to function.

Am I missing something, or is there another kind of "Promise FastTrack
100 TX2" floating around?
-- 
Zygo Blaxell (Laptop) <zblaxell@feedme.hungrycats.org>
GPG = D13D 6651 F446 9787 600B AD1E CCF3 6F93 2823 44AD
